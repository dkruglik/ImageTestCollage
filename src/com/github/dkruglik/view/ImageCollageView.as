/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.view {
import com.github.dkruglik.model.ImageLoadVO;
import com.github.dkruglik.view.layout.ILayoutBuilder;
import com.github.dkruglik.view.layout.LayoutFactory;
import com.github.dkruglik.view.renderer.ImageRendererView;

import flash.display.Sprite;
import flash.events.Event;

public class ImageCollageView extends Sprite {

    private var _data:Vector.<ImageLoadVO>;
    private var layoutBuilder:ILayoutBuilder;

    public function ImageCollageView() {
        super();
        init();
    }

    private function init():void {
        _data = new Vector.<ImageLoadVO>();
        layoutBuilder = LayoutFactory.createLayoutBuilder(LayoutFactory.LIGHTBOX);
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
    }

    private function onAddedToStageHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
        stage.addEventListener(Event.RESIZE, onResizeHandler);
    }

    private function onResizeHandler(event:Event):void {
        draw();
    }

    public function get data():Vector.<ImageLoadVO> {
        return _data;
    }

    public function setData(value:Vector.<ImageLoadVO>, forceDraw:Boolean):void {
        var newValue:Vector.<ImageLoadVO> = cloneDataValue(value);
        var toAdd:Vector.<ImageLoadVO> = new Vector.<ImageLoadVO>();

        while (newValue.length > 0) {
            var item:ImageLoadVO = newValue.shift();

            var foundInd:int = -1;
            for (var i:int = 0; i < _data.length; i++) {
                if (item.equals(_data[i])) {
                    foundInd = i;
                    break;
                }
            }
            if (foundInd == -1) {
                toAdd.push(item);
            } else {
                _data.splice(foundInd, 1);
            }

        }
        updateRenderers(toAdd, _data);

        _data = cloneDataValue(value);

        if (forceDraw) {
            draw();
        }

    }

    private function updateRenderers(toAdd:Vector.<ImageLoadVO>, toRemove:Vector.<ImageLoadVO>):void {
        removeUnusedRenderers(toRemove);
        addNewRenderers(toAdd);
    }

    private function removeUnusedRenderers(toRemove:Vector.<ImageLoadVO>):void {
        for each(var toRemoveItem:ImageLoadVO in toRemove) {
            var removeInd:int = -1;
            for (var i:int = 0; i < numChildren; i++) {
                if (toRemoveItem.equals((getChildAt(i) as ImageRendererView).data)) {
                    removeInd = i;
                    break;
                }
            }
            if (removeInd != -1) {
                var removedView:ImageRendererView = removeChildAt(removeInd) as ImageRendererView;
                removedView.dispose();
            }
        }
    }

    private function addNewRenderers(toAdd:Vector.<ImageLoadVO>):void {
        for each(var toAddItem:ImageLoadVO in toAdd) {
            var renderer:ImageRendererView = new ImageRendererView();
            renderer.data = toAddItem;
            addChild(renderer);
        }
    }

    private function draw():void {
        var children:Vector.<ImageRendererView> = new Vector.<ImageRendererView>();

        for (var i:int = 0; i < numChildren; i++) {
            children.push(getChildAt(i));
        }

        layoutBuilder.build(children, stage.stageWidth, stage.stageHeight);
    }

    private function cloneDataValue(value:Vector.<ImageLoadVO>):Vector.<ImageLoadVO> {
        var result:Vector.<ImageLoadVO> = new Vector.<ImageLoadVO>();
        for each(var item:ImageLoadVO in value) {
            result.push(item.clone());
        }

        return result;
    }
}
}
