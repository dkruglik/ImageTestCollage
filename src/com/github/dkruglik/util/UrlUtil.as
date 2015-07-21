/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.util {
import com.github.dkruglik.model.MaxMinImageSizeVO;

public class UrlUtil {

    private static const BASE_URL:String = "dummyimage.com";

    private static var _instance:UrlUtil;

    public function UrlUtil(force:Seal) {
        if (!force) {
            throw new Error("you must singleton instance method instead constructor");
        }
    }

    public static function get instance():UrlUtil {
        if (!_instance) {
            _instance = new UrlUtil(new Seal());
        }

        return _instance;
    }

    public function get baseUrl():String {
        return BASE_URL;
    }

    public function createRandomURL(boundaryImage:MaxMinImageSizeVO):String {
        var sizePart:String = randomInt(boundaryImage.maxWidth, boundaryImage.minWidth) + "x" + randomInt(boundaryImage.maxHeight, boundaryImage.minHeight);
        var colorPart:String = getRandomColor() + "/" + getRandomColor();
        return "http://" + BASE_URL + "/" + sizePart + "/" + colorPart;
    }

    private function getRandomColor():uint {
        return Math.random() * 0xFFFFFF;
    }

    private function randomInt(max:int, min:int):int {
        return Math.round(Math.random() * ((max - min) + 1)) + min
    }
}
}
class Seal {
}
