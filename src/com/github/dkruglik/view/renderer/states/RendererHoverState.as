/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.renderer.states {
import com.greensock.TweenMax;
import com.greensock.easing.Sine;

public class RendererHoverState extends RendererBaseState {

    override public function doAction():void {
        TweenMax.killTweensOf(this);
        TweenMax.to(_target, 0.1, {alpha: 0.6, ease: Sine.easeOut});
    }

}
}
