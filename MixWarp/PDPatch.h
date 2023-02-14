//
//  PDPatch.h
//  
//
//  Created by Cory Tripathy on 12/5/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PdDispatcher.h"

@interface PDPatch : NSObject

-(void)instanceCount:(float)channel toggle:(float)onOff;
-(void)instanceIsGoofy:(float)channel toggle:(float)onOff;
-(void)toggleRecord:(float)onOff;
-(void)toggleLoop:(float)onOff;
-(void)floatSpeedFader:(float)floatValue;
-(void)floatLoopStart:(float)floatValue;
-(void)floatLoopEnd:(float)floatValue;
-(void)sendBangToLoop;
-(void)sendBangToRecord;
-(void)floatTransportSliderStart:(float)floatValue;
-(void)floatTransportSliderEnd:(float)floatValue;
-(void)floatDelayTime:(float)floatValue;
-(void)floatDelayAmount:(float)floatValue;
-(void)bangClearDelay;


-(instancetype)initWithFile:(NSString *)pdFile;

@end
