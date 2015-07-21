/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.service {
import com.github.dkruglik.model.ImageLoadVO;
import com.github.dkruglik.model.LoadConfig;
import com.github.dkruglik.signals.ImagesLoadedSignal;

import flash.events.TimerEvent;
import flash.utils.Timer;

public class ImageLoadManager {

    [Inject]
    public var loadConfig:LoadConfig;

    [Inject]
    public var finishSignal:ImagesLoadedSignal;

    private var loadQueue:Vector.<Vector.<String>>;
    private var loadResult:Vector.<ImageLoadVO>;
    private var _urls:Vector.<String>;
    private var _serviceMap:Object;
    private var _serviceMapSize:int;
    private var _timer:Timer;

    public function ImageLoadManager() {
        super();
        init();
    }

    private function init():void {
        _serviceMap = {};
        _urls = new Vector.<String>();
        loadQueue = new Vector.<Vector.<String>>();
        loadResult = new Vector.<ImageLoadVO>();
    }

    public function loadImages(urls:Vector.<String>):void {
        if (isManagerEmpty()) {
            _urls = urls;
            loadResult = new Vector.<ImageLoadVO>();
            loadNext();
        } else {
            loadQueue.push(urls);
        }

    }

    private function loadNext():void {
        if (isReadyToLoad()) {
            var currentUrl:String = _urls.shift();
            var service:ImageLoadService = new ImageLoadService();
            service.addCompleteHandler(onImageLoadSuccessHandler);
            service.addErrorHandler(onImageLoadErrorHandler);
            addServiceToMap(currentUrl, service);
            service.loadURL(currentUrl);
        }
        if (isReadyToLoad()) {
            runTimer();
        }
        if (isManagerEmpty()) {
            loadFinishHandler();
        }
    }

    private function loadFinishHandler():void {
        stopTimer();
        finishSignal.dispatch(loadResult);
        if (loadQueue.length > 0) {
            loadImages(loadQueue.shift());
        } else {
            loadResult = null;
        }

    }

    private function runTimer():void {
        if (!_timer) {
            _timer = new Timer(1, 1);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
            _timer.start()
        }
    }

    private function stopTimer():void {
        if (_timer) {
            _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
            _timer.stop();
            _timer = null;
        }
    }

    private function onTimerComplete(event:TimerEvent):void {
        _timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        _timer = null;
        loadNext();
    }

    private function processLoadResult(url:String):void {
        var service:ImageLoadService = _serviceMap[url] as ImageLoadService;
        service.dispose();

        removeServiceFromMap(url);

        loadNext();
    }

    private function onImageLoadErrorHandler(url:String):void {
        processLoadResult(url);
    }

    private function onImageLoadSuccessHandler(vo:ImageLoadVO):void {
        loadResult.push(vo);
        processLoadResult(vo.url);
    }

    private function isReadyToLoad():Boolean {
        return !isFullBusy() && _urls.length > 0;
    }

    private function isFullBusy():Boolean {
        return _serviceMapSize >= loadConfig.maxDownloadConnection;
    }

    private function isManagerEmpty():Boolean {
        return _serviceMapSize == 0 && _urls.length == 0;
    }

    private function addServiceToMap(url:String, service:ImageLoadService):void {
        _serviceMap[url] = service;
        _serviceMapSize++;
    }

    private function removeServiceFromMap(url:String):void {
        delete _serviceMap[url];
        _serviceMapSize--;
    }
}
}
