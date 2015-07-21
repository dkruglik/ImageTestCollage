/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.renderer {
import com.github.dkruglik.signals.ImageClickedSignal;

import org.robotlegs.mvcs.Mediator;

public class ImageRendererMediator extends Mediator {

    [Inject]
    public var view:ImageRendererView;

    [Inject]
    public var imageClickedSignal:ImageClickedSignal;

    override public function onRegister():void {
        super.onRegister();
        view.imageClicked.add(onImageClickedHandler);
    }

    private function onImageClickedHandler():void {
        imageClickedSignal.dispatch(view.data);
    }
}
}
