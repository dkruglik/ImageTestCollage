/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.view.state {
import org.osflash.signals.Signal;

public interface IStateTarget {
    function get stateChanged():Signal;
}
}
