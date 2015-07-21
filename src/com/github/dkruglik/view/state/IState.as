/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.view.state {
public interface IState {

    function set target(value:Object):void;

    function doAction():void;

    function doStop():void;

    function dispose():void;
}
}
