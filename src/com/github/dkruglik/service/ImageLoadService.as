/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.service {
import com.github.dkruglik.model.ImageLoadVO;

import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;

import org.osflash.signals.Signal;

public class ImageLoadService extends Loader {

    private var _signalCompleteHandler:Function;
    private var _signalErrorHandler:Function;
    private var _completeSignal:Signal;
    private var _errorSignal:Signal;

    private var _loadedUrl:String;

    public function ImageLoadService() {
        super();
        init();
    }

    private function init():void {
        _completeSignal = new Signal(ImageLoadVO);
        _errorSignal = new Signal(String);
    }

    public function addCompleteHandler(completeHandler:Function):void {
        _signalCompleteHandler = completeHandler;
        _completeSignal.add(_signalCompleteHandler);
        contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
    }

    private function onLoadCompleteHandler(event:Event):void {
        _completeSignal.dispatch(ImageLoadVO.createFromLoader(event.currentTarget as LoaderInfo));
    }

    public function addErrorHandler(errorHandler:Function):void {
        _signalErrorHandler = errorHandler;
        _errorSignal.add(errorHandler);
        contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
        contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadErrorHandler);
        contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler);
    }

    private function onLoadErrorHandler(event:Event):void {
        _errorSignal.dispatch(loadedUrl);
    }

    private function onHttpStatusHandler(event:HTTPStatusEvent):void {
        if (Math.floor(event.status / 100) != 2) {
            _errorSignal.dispatch(loadedUrl);
        }
    }

    public function loadURL(url:String):void {
        this._loadedUrl = url;
        this.load(new URLRequest(url));
    }

    public function get loadedUrl():String {
        return _loadedUrl;
    }

    public function dispose():void {
        if (contentLoaderInfo.hasEventListener(Event.COMPLETE)) {
            contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onLoadCompleteHandler);
        }

        if (_signalCompleteHandler) {
            _completeSignal.remove(_signalCompleteHandler);
        }

        if (contentLoaderInfo.hasEventListener(IOErrorEvent.IO_ERROR)) {
            contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
        }

        if (contentLoaderInfo.hasEventListener(SecurityErrorEvent.SECURITY_ERROR)) {
            contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoadErrorHandler);
        }

        if (contentLoaderInfo.hasEventListener(HTTPStatusEvent.HTTP_STATUS)) {
            contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, this.onHttpStatusHandler);
        }

        if (_signalErrorHandler) {
            _errorSignal.remove(_signalErrorHandler)
        }

        _completeSignal = null;
        _errorSignal = null;

        _signalCompleteHandler = null;
        _signalErrorHandler = null;

        _loadedUrl = null;

        unload();
    }
}
}
