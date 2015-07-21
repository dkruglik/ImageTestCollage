/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.renderer {
import com.github.dkruglik.model.ImageLoadVO;
import com.github.dkruglik.view.renderer.states.RendererClickedState;
import com.github.dkruglik.view.renderer.states.RendererDownState;
import com.github.dkruglik.view.renderer.states.RendererHoverState;
import com.github.dkruglik.view.renderer.states.RendererNormalState;
import com.github.dkruglik.view.renderer.states.RendererShowState;
import com.github.dkruglik.view.state.IStateTarget;
import com.github.dkruglik.view.state.StateManager;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.Timer;

import org.osflash.signals.Signal;

public class ImageRendererView extends Sprite implements IStateTarget {

    public static const NORMAL_STATE:String = "normal";
    public static const HOVER_STATE:String = "hover";
    public static const DOWN_STATE:String = "down";
    public static const CLICKED_STATE:String = "clicked";
    public static const SHOW_STATE:String = "show";

    private var _data:ImageLoadVO;
    private var _image:Bitmap;
    private var _stateManager:StateManager;
    private var _stateChanged:Signal;
    private var _imageClicked:Signal;

    public function ImageRendererView() {
        super();
        init();
    }

    private function init():void {
        alpha = 0;
        _stateChanged = new Signal(String);
        _imageClicked = new Signal();
        _stateManager = new StateManager(this);
        _stateManager.addState(NORMAL_STATE, RendererNormalState, true);
        _stateManager.addState(HOVER_STATE, RendererHoverState, true);
        _stateManager.addState(DOWN_STATE, RendererDownState, true);
        _stateManager.addState(CLICKED_STATE, RendererClickedState, true);
        _stateManager.addState(SHOW_STATE, RendererShowState, true);

        addEventListener(MouseEvent.ROLL_OVER, onMouseOverHandler);
        addEventListener(MouseEvent.ROLL_OUT, onMouseOutHandler);
        addEventListener(MouseEvent.CLICK, onMouseClickHandler);

        stateChanged.dispatch(SHOW_STATE);
    }

    private function onMouseOutHandler(event:MouseEvent):void {
        stateChanged.dispatch(NORMAL_STATE);
    }

    private function onMouseClickHandler(event:MouseEvent):void {
        stateChanged.dispatch(CLICKED_STATE);
        var timer:Timer = new Timer(300, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        timer.start()

    }

    private function onTimerComplete(event:TimerEvent):void {
        event.currentTarget.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        _imageClicked.dispatch();
    }

    private function onMouseOverHandler(event:MouseEvent):void {
        stateChanged.dispatch(HOVER_STATE);
    }

    public function get stateChanged():Signal {
        return _stateChanged;
    }

    public function get imageClicked():Signal {
        return _imageClicked;
    }

    public function get data():ImageLoadVO {
        return _data;
    }

    public function set data(value:ImageLoadVO):void {
        if (value) {
            disposeBitmapData();
            _data = value;
            _image = new Bitmap();
            _image.bitmapData = value.bitmapData;
            addChild(_image);
        }
    }

    public function changePosition(rect:Rectangle):void {
        this.x = rect.x;
        this.y = rect.y;
        var scaleFactor:Number = Math.min(rect.width / _data.bitmapData.width, rect.height / _data.bitmapData.height);
        var newWidth:Number = Math.round(_data.bitmapData.width * scaleFactor);
        var newHeight:Number = Math.round(_data.bitmapData.height * scaleFactor);

        if (newWidth < 1)
            newWidth = 1;

        if (newHeight < 1)
            newHeight = 1;

        var scaledBitmapData:BitmapData = new BitmapData(newWidth, newHeight, true, 0xFFFFFFFF);
        var scaleMatrix:Matrix = new Matrix();
        scaleMatrix.scale(scaleFactor, scaleFactor);
        scaledBitmapData.draw(_data.bitmapData, scaleMatrix);

        _image.bitmapData = scaledBitmapData;
        _image.x = (rect.width - scaledBitmapData.width) / 2;
        _image.y = (rect.height - scaledBitmapData.height) / 2;
    }

    private function disposeBitmapData():void {
        if (_image) {
            removeChild(_image);
            if (_image.bitmapData) {
                _image.bitmapData.dispose();
            }
            _image = null;
        }
    }

    public function dispose():void {
        removeEventListener(MouseEvent.ROLL_OVER, onMouseOverHandler);
        removeEventListener(MouseEvent.ROLL_OUT, onMouseOutHandler);
        removeEventListener(MouseEvent.CLICK, onMouseClickHandler);

        _stateManager.dispose();

        if(_data && _data.bitmapData) {
            _data.bitmapData.dispose();
        }

        disposeBitmapData();
    }

    public function get bitmapWidth():Number {
        return _image ? _image.bitmapData.width : 0;
    }

    public function get bitmapHeight():Number {
        return _image ? _image.bitmapData.height : 0;
    }
}
}
