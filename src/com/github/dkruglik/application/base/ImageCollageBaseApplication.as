/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.application.base {
import com.github.dkruglik.application.IImageCollageApplication;

import flash.display.Sprite;
import flash.events.Event;

import org.robotlegs.mvcs.SignalContext;

public class ImageCollageBaseApplication extends Sprite implements IImageCollageApplication {

    protected var _context:SignalContext;

    public function ImageCollageBaseApplication() {
        super();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
    }

    private function onAddedToStageHandler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
        initContext();
        initApp();
    }

    public function initContext():void {
        throw new Error("Context must be init");
    }

    public function initApp():void {
        throw new Error("App must be init");
    }
}
}
