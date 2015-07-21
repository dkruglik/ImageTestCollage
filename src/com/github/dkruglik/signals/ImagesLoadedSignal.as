/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.signals {
import com.github.dkruglik.model.ImageLoadVO;

import org.osflash.signals.Signal;

public class ImagesLoadedSignal extends Signal {

    public function ImagesLoadedSignal() {
        super(Vector.<ImageLoadVO>);
    }
}
}
