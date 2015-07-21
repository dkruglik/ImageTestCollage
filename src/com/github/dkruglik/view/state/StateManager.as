/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.view.state {
import com.github.dkruglik.view.state.vo.StateInstanceVO;

public class StateManager {

    private var _target:IStateTarget;
    private var _states:Object;
    private var _currentState:String;

    public function StateManager(target:IStateTarget) {
        _target = target;
        _currentState = "none";
        _target.stateChanged.add(onStateChangedHandler);
        _states = {};
    }

    public function addState(key:String, stateClass:Class, isLazy:Boolean):void {
        if (_states.hasOwnProperty(key)) {
            if (_states[key].stateClass != stateClass) {
                _states[key].stateInstance = null;
                _states[key].stateClass = stateClass;
            }
        } else {
            var instanceVO:StateInstanceVO = new StateInstanceVO();
            instanceVO.stateClass = stateClass;

            _states[key] = instanceVO;
        }

        if (!isLazy && !_states[key].stateInstance) {
            _states[key].stateInstance = createStateInstance(stateClass);
        }
    }

    private function onStateChangedHandler(state:String):void {
        if (_currentState != state) {
            stopCurrentState();

            var stateInstance:IState = getStateInstanceByName(state);
            if (stateInstance) {
                stateInstance.doAction();
            }
        }
    }

    private function stopCurrentState():void {
        var stateInstance:IState = getStateInstanceByName(_currentState);
        if (stateInstance) {
            stateInstance.doStop();
        }
    }

    private function getStateInstanceByName(state:String):IState {
        if (_states.hasOwnProperty(state)) {
            var instanceVO:StateInstanceVO = StateInstanceVO(_states[state]);

            if (!instanceVO.stateInstance) {
                instanceVO.stateInstance = createStateInstance(instanceVO.stateClass);
            }

            return instanceVO.stateInstance;
        }

        return null;
    }

    private function createStateInstance(stateClass:Class):IState {
        var state:IState = IState(new stateClass());
        state.target = _target;

        return state;
    }

    public function dispose():void {
        _target.stateChanged.remove(onStateChangedHandler);

        for (var key:String in _states) {
            var instanceVO:StateInstanceVO = StateInstanceVO(_states[key]);
            instanceVO.dispose();

            delete _states[key];
        }

        _states = null;
    }
}
}
