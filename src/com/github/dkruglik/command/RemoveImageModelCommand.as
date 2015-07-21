/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.command {
import com.github.dkruglik.model.BaseApplicationModel;
import com.github.dkruglik.model.ImageLoadVO;

import org.robotlegs.mvcs.Command;

public class RemoveImageModelCommand extends Command {

    [Inject]
    public var imageVO:ImageLoadVO;

    [Inject]
    public var model:BaseApplicationModel;

    override public function execute():void {
        model.removeImage(imageVO);
    }
}
}
