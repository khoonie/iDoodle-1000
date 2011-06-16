#import "soundMusic.h"
#import "SynthesizeSingleton.h"

@implementation SoundMusic

SYNTHESIZE_SINGLETON_FOR_CLASS(SoundMusic);

@synthesize soundEffect0, soundEffect1;

-(id)init
{
    
    if ((self = [super init])) {
        
        
        soundArray = [[NSMutableArray alloc] init];
        
        Sound01 = [self prepareData:@"harp1" fileType:@"wav"];
        // Check if Sound01 returns -1
        Sound01 = [self prepareData:@"harp2" fileType:@"wav"];
          
    }
    
    return self;
}

-(int)prepareData:(NSString*)filename fileType:(NSString*)fileType 
{
    int currentSoundIndex= -1;
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSError *error;
    
    NSURL *soundURL0 = [NSURL fileURLWithPath:[mainBundle pathForResource:filename ofType:fileType]];
    soundEffect0 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL0 error:&error];
    
    if (!soundEffect0) {
        NSLog(@"no sound effect %@", filename);
    }
    else
    {
        [soundEffect0 prepareToPlay];
        [soundEffect0 setDelegate:self];
        soundEffect0.numberOfLoops = 0;
        soundEffect0.volume = 1;
        [soundArray addObject:soundEffect0];
        currentSoundIndex = [soundArray indexOfObject:soundEffect0];    
    }
    
    return currentSoundIndex;
}


-(void)playSoundEffect:(int)soundType
{
        
    if ([soundEffect0 isPlaying]) {
        soundEffect1 = [soundArray objectAtIndex:soundType];
        if ([soundEffect1 isPlaying] && soundType == 1) {
            [soundEffect1 setCurrentTime:0];
        }        
        [soundEffect1 play];
    }
    else
    {
        soundEffect0 = [soundArray objectAtIndex:soundType];
        if ([soundEffect0 isPlaying] && soundType == 1) {
            [soundEffect0 setCurrentTime:0];
        }
        [soundEffect0 play];
    }
}

-(void) audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    
}

-(void) audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    
}

-(void) audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    
}

-(void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

-(void) dealloc
{
    
    [super dealloc];
    [soundEffect0 release];
    [soundEffect1 release];
    
}
@end
