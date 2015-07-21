/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.renderer.states {
import com.github.dkruglik.view.renderer.ImageRendererView;
import com.github.dkruglik.view.state.IState;
import com.greensock.TweenMax;

public class RendererBaseState implements IState {

    protected var _target:ImageRendererView;

    public function set target(value:Object):void {
        _target = value as ImageRendererView;
    }

    public function doAction():void {
        throw new Error("must be overriden");
    }

    public function doStop():void {
        TweenMax.killTweensOf(this);
    }

    public function dispose():void {
        TweenMax.killTweensOf(this);
        _target = null;
    }
}
}
