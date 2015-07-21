/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.model {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.LoaderInfo;

public class ImageLoadVO {

    private var _url:String;
    private var _bitmapData:BitmapData;


    public function get url():String {
        return _url;
    }

    public function set url(value:String):void {
        _url = value;
    }

    public function get bitmapData():BitmapData {
        return _bitmapData;
    }

    public function set bitmapData(value:BitmapData):void {
        _bitmapData = value;
    }

    public static function createFromLoader(loaderInfo:LoaderInfo):ImageLoadVO {
        var result:ImageLoadVO = new ImageLoadVO();
        result.bitmapData = Bitmap(loaderInfo.content).bitmapData;
        result.url = loaderInfo.url;

        return result;
    }

    public function clone():ImageLoadVO {
        var result:ImageLoadVO = new ImageLoadVO();
        result.url = this.url;
        result.bitmapData = this.bitmapData.clone();

        return result;
    }

    public function equals(value:ImageLoadVO):Boolean {
        return url == value.url;
    }

    public function dispose() : void {
        url = null;
        bitmapData.dispose();
        bitmapData = null;
    }
}
}
