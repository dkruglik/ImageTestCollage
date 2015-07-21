/**
 * Created by dkruglik on 7/20/15.
 */
package com.github.dkruglik.model {
public class LoadConfig {

    private var _maxImageLoadCount:int;
    private var _boundaryImageSize:MaxMinImageSizeVO;
    private var _maxDownloadConnection:int;

    public function LoadConfig() {
        _maxImageLoadCount = 30;
        _boundaryImageSize = new MaxMinImageSizeVO();
        _boundaryImageSize.maxWidth = 400;
        _boundaryImageSize.minWidth = 100;
        _boundaryImageSize.maxHeight = 300;
        _boundaryImageSize.minHeight = 100;
        _maxDownloadConnection = 5;
    }

    public function get maxImageLoadCount():int {
        return _maxImageLoadCount;
    }

    public function set maxImageLoadCount(value:int):void {
        _maxImageLoadCount = value;
    }

    public function get boundaryImageSize():MaxMinImageSizeVO {
        return _boundaryImageSize;
    }

    public function set boundaryImageSize(value:MaxMinImageSizeVO):void {
        _boundaryImageSize = value;
    }

    public function get maxDownloadConnection():int {
        return _maxDownloadConnection;
    }

    public function set maxDownloadConnection(value:int):void {
        _maxDownloadConnection = value;
    }
}
}
