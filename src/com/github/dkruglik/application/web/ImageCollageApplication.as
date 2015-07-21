/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.application.web {
import com.github.dkruglik.application.base.ImageCollageBaseApplication;
import com.github.dkruglik.application.context.ImageCollageContext;
import com.github.dkruglik.util.UrlUtil;
import com.github.dkruglik.view.ImageCollageView;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.system.Security;

[SWF(width="1024", height="768", scaleMode="noScale", backgroundColor="0xFFFFFF")]
public class ImageCollageApplication extends ImageCollageBaseApplication {

    public function ImageCollageApplication() {
        super();
    }

    override public function initContext():void {
        _context = new ImageCollageContext(this);
    }

    override public function initApp():void {
        Security.allowDomain(UrlUtil.instance.baseUrl);
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        var imageView:ImageCollageView = new ImageCollageView();
        addChild(imageView);
    }
}
}
