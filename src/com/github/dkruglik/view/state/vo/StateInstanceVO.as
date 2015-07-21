/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.view.state.vo {
import com.github.dkruglik.view.state.IState;

public class StateInstanceVO {

    private var _stateClass:Class;
    private var _stateInstance:IState;

    public function get stateClass():Class {
        return _stateClass;
    }

    public function set stateClass(value:Class):void {
        _stateClass = value;
    }

    public function get stateInstance():IState {
        return _stateInstance;
    }

    public function set stateInstance(value:IState):void {
        _stateInstance = value;
    }

    public function dispose():void {
        if (stateInstance) {
            stateInstance.dispose();
        }
        _stateClass = null;
        stateInstance = null;
    }
}
}
