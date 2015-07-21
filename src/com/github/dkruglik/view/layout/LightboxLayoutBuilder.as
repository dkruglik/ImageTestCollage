/**
 * Created by dkruglik on 7/21/15.
 */
package com.github.dkruglik.view.layout {
import com.github.dkruglik.view.renderer.ImageRendererView;

import flash.geom.Point;
import flash.geom.Rectangle;

public class LightboxLayoutBuilder implements ILayoutBuilder {

    public static const COLUMN_WIDTH:int = 120;
    public static const MARGIN:int = 6;
    public static const DELTA:int = 10;
    public static const SIZE_BORDER:int = 10;

    private var heights:Array;
    private var maxHeight:Number;

    public function LightboxLayoutBuilder() {
        heights = [];
    }

    public function build(value:Vector.<ImageRendererView>, stageWidth:Number, stageHeight:Number):void {
        maxHeight = stageHeight;
        var size:Number = stageWidth - SIZE_BORDER;
        var columnsCount:int = Math.floor(size / (COLUMN_WIDTH + MARGIN));
        initColumns(columnsCount);

        for (var i:int = 0; i < value.length; i++) {
            addImage(value[i]);
        }
    }

    private function addImage(image:ImageRendererView):void {
        var column:int = getMinColumnInd();
        var rowspan:int = 0;
        if (Math.random() > 0.5) {
            if (column - 1 > 0 && heights[column - 1] <= heights[column]) {
                rowspan = -1;
            } else if (column + 1 < heights.length && heights[column + 1] <= heights[column]) {
                rowspan = 1;
            }
        }
        addColumnElement(column, image, rowspan);
    }

    private function addColumnElement(columnInd:int, elem:ImageRendererView, rowspan:int/* -1, 0 or 1 */) {
        var newDimension:Point = getFitSize(elem, 1 + Math.abs(rowspan));

        newDimension.y -= (heights[columnInd] + newDimension.y + MARGIN) % DELTA;

        var newX:Number = MARGIN + (COLUMN_WIDTH + MARGIN) * (columnInd + (rowspan === -1 ? -1 : 0));
        var newY:Number = heights[columnInd];
        var newWidth:Number = newDimension.x;
        var newHeight:Number = newDimension.y;

        if ((newY + newHeight) > maxHeight) {
            newHeight = maxHeight - newY;
            if (newHeight < 0) {
                var newColumnInd:int = (columnInd + 1) < heights.length ? (columnInd + 1) : heights.length - 1;
                if (columnInd == newColumnInd) {
                    newHeight = newDimension.y;
                } else {
                    addColumnElement(newColumnInd, elem, rowspan);
                    return;
                }
            }
        }

        elem.changePosition(new Rectangle(newX, newY, newWidth, newHeight));
        var nextHeight:Number = heights[columnInd] + newDimension.y + MARGIN;
        heights[columnInd + rowspan] = heights[columnInd] = nextHeight;
    }

    private function getFitSize(image:ImageRendererView, rowspan:int) {
        var newWidth:Number = COLUMN_WIDTH * rowspan;
        if (rowspan > 1) {
            newWidth += MARGIN;
        }
        var newHeight:Number = (image.bitmapHeight * newWidth) / image.bitmapWidth;

        return new Point(newWidth, newHeight);
    }

    private function getMinColumnInd():int {
        var minHeight:Number = Number.MAX_VALUE;
        var minIndex:int = -1;
        for (var i:int = 0; i < heights.length; ++i) {
            if (heights[i] < minHeight) {
                minHeight = heights[i];
                minIndex = i;
            }
        }
        return minIndex;
    }

    private function initColumns(count:int) {
        heights = [];
        for (var i:int = 0; i < count; i++) {
            heights.push(MARGIN);
        }
    }
}
}
