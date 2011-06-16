#import "cocos2d.h"


@protocol sliderDelegate;

@interface doodleLayer : CCLayer
{

    int state;
    NSString *string;
    id <sliderDelegate> delegate;
    int previousX, currentX;
    CCSprite *eraser;
    CCSprite *whiteBoard;
    CCParticleSystem *emitter;
    CCParticleSystem *emitter2;
    CCRenderTexture *target;
}


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


-(void)setupPalette;
-(void)eraseStripX:(int)x;

@property (nonatomic, assign) NSString *string;
@property (nonatomic, assign) id <sliderDelegate> delegate;
@property (readwrite, retain) CCParticleSystem *emitter;
@property (readwrite, retain) CCParticleSystem *emitter2;
@end

@protocol sliderDelegate

-(void)eraseScreenX:(int)x;

@end