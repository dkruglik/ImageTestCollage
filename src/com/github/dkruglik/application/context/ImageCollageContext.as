/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.application.context {
import com.github.dkruglik.command.AddLoadedImagesCommand;
import com.github.dkruglik.command.ImageLoadingCommand;
import com.github.dkruglik.command.PrepareImageLoadCommand;
import com.github.dkruglik.command.RemoveImageModelCommand;
import com.github.dkruglik.model.BaseApplicationModel;
import com.github.dkruglik.model.LoadConfig;
import com.github.dkruglik.service.ImageLoadManager;
import com.github.dkruglik.signals.ImageClickedSignal;
import com.github.dkruglik.signals.ImagesLoadedSignal;
import com.github.dkruglik.signals.ModelChangedSignal;
import com.github.dkruglik.signals.ModelRemoveSignal;
import com.github.dkruglik.signals.PrepareImageLoadSignal;
import com.github.dkruglik.signals.StartImageLoadingSignal;
import com.github.dkruglik.view.ImageCollageMediator;
import com.github.dkruglik.view.ImageCollageView;
import com.github.dkruglik.view.renderer.ImageRendererMediator;
import com.github.dkruglik.view.renderer.ImageRendererView;

import flash.display.DisplayObjectContainer;

import org.robotlegs.mvcs.SignalContext;

public class ImageCollageContext extends SignalContext {

    public function ImageCollageContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
        super(contextView, autoStartup);
    }

    override public function startup():void {
        super.startup();
        injector.mapSingleton(LoadConfig);
        injector.mapSingleton(ImageLoadManager);
        injector.mapSingleton(BaseApplicationModel);
        injector.mapSingleton(ModelChangedSignal);
        injector.mapSingleton(ModelRemoveSignal);

        mediatorMap.mapView(ImageCollageView, ImageCollageMediator);
        mediatorMap.mapView(ImageRendererView, ImageRendererMediator);

        signalCommandMap.mapSignalClass(PrepareImageLoadSignal, PrepareImageLoadCommand);
        signalCommandMap.mapSignalClass(StartImageLoadingSignal, ImageLoadingCommand);
        signalCommandMap.mapSignalClass(ImagesLoadedSignal, AddLoadedImagesCommand);
        signalCommandMap.mapSignalClass(ImageClickedSignal, RemoveImageModelCommand);
    }
}
}
