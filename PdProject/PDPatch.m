//
//  PDPatch.m
//  
//
//  Created by Cory Tripathy on 12/5/22.
//

#import "PDPatch.h"
#import "PdFile.h"

@implementation PDPatch

-(void)instanceCount:(float)channel toggle:(float)onOff{
    NSArray *list = @[@(channel), @(onOff)];
    [PdBase sendList:list toReceiver:@"instanceCount"];
}

-(void)toggleRecord:(float)onOff {
    [PdBase sendFloat: onOff toReceiver: @"toggleRecord"];
}

-(void)toggleLoop:(float)onOff {
    [PdBase sendFloat: onOff toReceiver: @"toggleLoop"];
}

-(void)floatSpeedFader:(float)floatValue {
    [PdBase sendFloat: floatValue toReceiver: @"floatFader"];
}
-(void)floatLoopStart:(float)floatValue {
    [PdBase sendFloat: floatValue toReceiver: @"floatLoopStart"];
}
-(void)floatLoopEnd:(float)floatValue {
    [PdBase sendFloat: floatValue toReceiver: @"floatLoopEnd"];
}

-(void)sendBangToLoop{
    [PdBase sendBangToReceiver:@"toggleLoop"];
}
-(void)sendBangToRecord{
    [PdBase sendBangToReceiver:@"toggleRecord"];
}

-(void)instanceIsGoofy:(float)channel toggle:(float)onOff{
    NSArray *list = @[@(channel), @(onOff)];
    [PdBase sendList:list toReceiver:@"instanceIsGoofy"];
}


-(instancetype)initWithFile:(NSString *)pdFile{
    void *patch;
    self = [super init];
    if(self){
        patch = [PdBase openFile:pdFile path:[[NSBundle mainBundle]resourcePath]];
//        if(!patch){
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"uh-oh" message: @"Pd patch not found" delegate:self cancelButtonTitle: @"poop" otherButtonTitles: nil, nil];
//            [alert show];
//        }
    }
    return self;
}

@end 
