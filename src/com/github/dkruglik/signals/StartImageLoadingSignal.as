/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.signals {
import org.osflash.signals.Signal;

public class StartImageLoadingSignal extends Signal {

    public function StartImageLoadingSignal() {
        super(Vector.<String>);
    }
}
}
