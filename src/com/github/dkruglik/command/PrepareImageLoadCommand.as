/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.command {
import com.github.dkruglik.model.LoadConfig;
import com.github.dkruglik.signals.StartImageLoadingSignal;
import com.github.dkruglik.util.UrlUtil;

import org.robotlegs.mvcs.Command;

public class PrepareImageLoadCommand extends Command {

    [Inject]
    public var maxCount:int;

    [Inject]
    public var loadConfig:LoadConfig;

    [Inject]
    public var loadSignal:StartImageLoadingSignal;

    override public function execute():void {
        var urls:Vector.<String> = new Vector.<String>();
        for (var i:int = 0; i < maxCount; i++) {
            urls.push(UrlUtil.instance.createRandomURL(loadConfig.boundaryImageSize));
        }

        loadSignal.dispatch(urls);
    }
}
}
