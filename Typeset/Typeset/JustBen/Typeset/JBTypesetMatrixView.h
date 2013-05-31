//
//  JBTypesetMatrixView.h
//  sxrc
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

#import "UIView+Flexible.h"
#import "JBFlexibleViewDelegate.h"

#import "JBTypesetBoardView.h"
#import "JBFlexibleLabel.h"
#import "JBFlexibleMultilineLabel.h"
#import "JBFlexibleTableView.h"
#import "JBFlexibleView.h"
#import "JBFlexibleButton.h"
#import "JBFlexibleTextField.h"
#import "JBFlexibleTextView.h"
#import "JBFlexibleImageView.h"


typedef enum {
    MatrixViewTypeInvalid = -1,
    MatrixViewTypeCustomView = 0,
    MatrixViewTypeLabel = 1,
    MatrixViewTypeMultilineLabel = 2,
    MatrixViewTypeButton = 3,
    MatrixViewTypePlainTable = 4,
    MatrixViewTypeGroupedTable = 5,
    MatrixViewTypeTextField = 6,
    MatrixViewTypeTextView = 7,
    MatrixViewTypeImageView = 8,
    MatrixViewTypeBoard = 9,
} MatrixViewType;



@interface JBTypesetMatrixView : UIView <JBFlexibleViewDelegate>

@property (nonatomic, assign) id <JBFlexibleViewDelegate> flexibleViewDelegate;

//  matrix view type
@property (nonatomic, assign) MatrixViewType matrixViewType;

//  matrixView
@property (nonatomic, retain) UIView *matrixView;

@property (nonatomic, assign) CGFloat   minHeight;

//  clear setting to initial status
- (void)clearSettings;

@end
