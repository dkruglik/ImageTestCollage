/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.layout {
public class LayoutFactory {

    public static const LIGHTBOX:String = "lightbox";

    public static function createLayoutBuilder(type:String):ILayoutBuilder {
        switch (type) {
            case LIGHTBOX:
                return new LightboxLayoutBuilder();
            default :
                return new EmptyLayoutBuilder();
        }

    }
}
}
