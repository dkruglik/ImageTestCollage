/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.renderer.states {
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

public class RendererShowState extends RendererBaseState {

    override public function doAction():void {
        TweenMax.killTweensOf(this);
        TweenMax.to(_target, 0.5, {alpha: 1, ease: Sine.easeIn});
    }
}
}
