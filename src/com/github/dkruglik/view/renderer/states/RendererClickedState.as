/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.renderer.states {
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

public class RendererClickedState extends RendererBaseState {

    override public function doAction():void {
        TweenMax.killTweensOf(this);
        TweenMax.to(_target, 0.3, {alpha: 0, ease: Sine.easeOut});
    }
}
}
