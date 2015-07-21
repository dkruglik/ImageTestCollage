/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.model {
import com.github.dkruglik.signals.ModelChangedSignal;
import com.github.dkruglik.signals.ModelRemoveSignal;

public class BaseApplicationModel {

    [Inject]
    public var changedSignal:ModelChangedSignal;

    [Inject]
    public var removeSignal:ModelRemoveSignal;

    private var _images:Vector.<ImageLoadVO>;

    public function BaseApplicationModel() {
        _images = new Vector.<ImageLoadVO>();
    }

    public function addImages(newImages:Vector.<ImageLoadVO>):void {
        _images = _images.concat(newImages);
        changedSignal.dispatch();
    }

    public function removeImage(imageLoadVO:ImageLoadVO):void {
        var removedInd:int = -1;
        for (var i:int = 0; i < _images.length; i++) {
            if (imageLoadVO.equals(_images[i])) {
                _images[i].dispose();
                removedInd = i;
                break;
            }
        }

        if (removedInd != -1) {
            _images.splice(removedInd, 1);
        }

        removeSignal.dispatch();
    }

    public function get images():Vector.<ImageLoadVO> {
        return _images;
    }
}
}
