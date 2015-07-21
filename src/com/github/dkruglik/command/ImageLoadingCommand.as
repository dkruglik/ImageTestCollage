/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.command {
import com.github.dkruglik.service.ImageLoadManager;

import org.robotlegs.mvcs.Command;

public class ImageLoadingCommand extends Command {

    [Inject]
    public var urls:Vector.<String>;

    [Inject]
    public var loadManager:ImageLoadManager;

    override public function execute():void {
        loadManager.loadImages(urls);
    }
}
}
