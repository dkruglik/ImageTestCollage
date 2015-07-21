/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.view {
import com.github.dkruglik.model.BaseApplicationModel;
import com.github.dkruglik.model.LoadConfig;
import com.github.dkruglik.signals.ModelChangedSignal;
import com.github.dkruglik.signals.ModelRemoveSignal;
import com.github.dkruglik.signals.PrepareImageLoadSignal;

import org.robotlegs.mvcs.Mediator;

public class ImageCollageMediator extends Mediator {

    [Inject]
    public var initAppSignal:PrepareImageLoadSignal;

    [Inject]
    public var loadConfig:LoadConfig;

    [Inject]
    public var model:BaseApplicationModel;

    [Inject]
    public var changedSignal:ModelChangedSignal;

    [Inject]
    public var removeSignal:ModelRemoveSignal;

    [Inject]
    public var view:ImageCollageView;

    override public function onRegister():void {
        super.onRegister();
        changedSignal.add(onModelChangedHandler);
        removeSignal.add(onModelRemoveHandler);
        initAppSignal.dispatch(loadConfig.maxImageLoadCount);
    }

    private function onModelRemoveHandler():void {
        view.setData(model.images, false);
        initAppSignal.dispatch(1);
    }

    private function onModelChangedHandler():void {
        view.setData(model.images, true);
    }
}
}
