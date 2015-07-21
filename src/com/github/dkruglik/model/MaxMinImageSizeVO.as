/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.model {
public class MaxMinImageSizeVO {

    private var _maxWidth:Number;
    private var _minWidth:Number;
    private var _maxHeight:Number;
    private var _minHeight:Number;

    public function MaxMinImageSizeVO() {
    }

    public function get maxWidth():Number {
        return _maxWidth;
    }

    public function set maxWidth(value:Number):void {
        _maxWidth = value;
    }

    public function get minWidth():Number {
        return _minWidth;
    }

    public function set minWidth(value:Number):void {
        _minWidth = value;
    }

    public function get maxHeight():Number {
        return _maxHeight;
    }

    public function set maxHeight(value:Number):void {
        _maxHeight = value;
    }

    public function get minHeight():Number {
        return _minHeight;
    }

    public function set minHeight(value:Number):void {
        _minHeight = value;
    }
}
}
