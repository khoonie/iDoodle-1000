#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundMusic : NSObject <AVAudioPlayerDelegate> {
    
    // Create 2 buffers
    AVAudioPlayer *soundEffect0;
    AVAudioPlayer *soundEffect1;
    NSMutableArray *soundArray;
    
    int Sound01;
}

@property (retain, nonatomic)  AVAudioPlayer *soundEffect0;
@property (retain, nonatomic)  AVAudioPlayer *soundEffect1;

-(int)prepareData:(NSString*)filename fileType:(NSString*)fileType ;
-(void)playSoundEffect:(int)soundType;
+(SoundMusic *)sharedSoundMusic;

@end