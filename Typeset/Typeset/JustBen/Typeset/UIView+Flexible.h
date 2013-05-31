//
//  UIView+Flexible.h
//  ImageView
//
//  Created by YongbinZhang on 4/10/13.
//  
//  Copyright (c) 2013 YongbinZhang
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>


#ifndef BgImageViewTag
#define BgImageViewTag  1010101
#endif

@protocol FlexibleViewDelegate <NSObject>

@optional
- (void)viewFrameChangedWithOldFrame:(CGRect)oldFrame NewFrame:(CGRect)newFrame;

@end


@interface UIView (Flexible) <FlexibleViewDelegate>


/**************************************************
 *@Description:set stretch image
 *@Params:
 *  stretchImage:stretch image
 *  leftCapWidth:default is 0. if non-zero, horiz. stretchable. right cap is calculated as width - leftCapWidth - 1
 *  topCapHeight:default is 0. if non-zero, vert. stretchable. bottom cap is calculated as height - topCapWidth - 1
 *@Return:nil
 **************************************************/
- (void)setStretchImage:(UIImage *)stretchImage WithLeftCapWidth:(NSInteger)leftCapWidth TopCapHeight:(NSInteger)topCapHeight;


/*************************************************
 *@Description:observe 'frame' variable or close
 *@Params:
 *  observe:YES-start observe; NO-close observe
 *@Return:nil
 *************************************************/
- (void)observeViewFrameChanging:(BOOL)observe;


@end