/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.layout {
import com.github.dkruglik.view.renderer.ImageRendererView;

public interface ILayoutBuilder {

    function build(value:Vector.<ImageRendererView>, stageWidth:Number, stageHeight:Number):void;
}
}
