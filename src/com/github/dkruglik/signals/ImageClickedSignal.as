/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.signals {
import com.github.dkruglik.model.ImageLoadVO;

import org.osflash.signals.Signal;

public class ImageClickedSignal extends Signal {

    public function ImageClickedSignal() {
        super(ImageLoadVO);
    }
}
}
