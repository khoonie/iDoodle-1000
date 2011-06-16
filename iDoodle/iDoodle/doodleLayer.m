#import "doodleLayer.h"
#import "soundMusic.h"

// HelloWorldLayer implementation
@implementation doodleLayer

@synthesize string;
@synthesize delegate;
@synthesize emitter;
@synthesize emitter2;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	doodleLayer *layer = [doodleLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
        
        self.isTouchEnabled = YES;
        self.isAccelerometerEnabled = NO;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        target = [[CCRenderTexture renderTextureWithWidth:size.width height:size.height] retain];
        target.anchorPoint = ccp(0.5,0.5);
        [target setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:target z:0];

        whiteBoard = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"whitescreen.png" ]];
        whiteBoard.anchorPoint = ccp(0.5,0.5);
        whiteBoard.position = ccp(size.width/2, size.height/2);
        
        [whiteBoard retain];

        [target begin];
        [whiteBoard visit];
        [target end];
        
        CCSprite *mainInterface = [CCSprite spriteWithFile:@"top.png"];
        mainInterface.anchorPoint = ccp(0.5,0.5);
        mainInterface.position = ccp(size.width/2, size.height/2);
        [self addChild:mainInterface z:2];
        
        [self setupPalette];
     
        state = 0;
        string = [NSString stringWithString:@"brush.png"];
        currentX = 0;
        previousX = 0;
        
        emitter2 = [CCParticleSystemQuad particleWithFile:@"brush.plist"];
        emitter2.position = ccp(64, 640);
        [self addChild:emitter2 z:3];
        
        sm = [SoundMusic sharedSoundMusic];
        [sm init];
		}
	return self;
}

-(void) onEnter
{
    
    
    [super onEnter];
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
    
}

-(void)eraseStripX:(int)x
{
    previousX = currentX;
    currentX = x;
    
    self.emitter = [CCParticleSystemQuad particleWithFile:@"stars.plist"];
    emitter.autoRemoveOnFinish = YES;
    emitter.position = ccp(currentX+128, 386);
    
    [self addChild:emitter z:3];
    
    
    [sm playSoundEffect:0];
    
    [target begin];
    if (previousX < currentX) {
        
        CGRect tempRect = CGRectMake(previousX-1, 64, (currentX-previousX), 640);
        eraser = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"whitescreen.png" ]rect:tempRect];
        eraser.anchorPoint = ccp(0,0);
        eraser.position = ccp( previousX+128, 64);
        [eraser visit];
        //[self addChild:eraser z:1];
    
    } else
    {
        CGRect tempRect2 = CGRectMake(currentX, 64, (previousX - currentX), 640);
        eraser = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] textureForKey:@"whitescreen.png" ]rect:tempRect2];
        eraser.anchorPoint = ccp(0,0);
        eraser.position = ccp( currentX+128, 64);
        [eraser visit];
        
        //[self addChild:eraser z:1];
    }
    [target end];
    
}


-(void)resetEmitter:(int)i
{
    int y= 640 - (i*128);
    [emitter2 stopSystem];
    [self removeChild:emitter2 cleanup:YES];
    
    [sm playSoundEffect:1];
    
    switch (i) {
        case 0:
            emitter2 = [CCParticleSystemQuad particleWithFile:@"brush.plist"];
            break;
        case 1:
            emitter2 = [CCParticleSystemQuad particleWithFile:@"circle.plist"];            
            break;
        case 2:
            emitter2 = [CCParticleSystemQuad particleWithFile:@"triangle.plist"];
            break;
        case 3:
            emitter2 = [CCParticleSystemQuad particleWithFile:@"square.plist"];
            break;
        default:
            break;
    }

    emitter2.position = ccp(64,y);
    [self addChild:emitter2 z:3];
    
}

-(void)pressButton1:(id)sender
{
    
    state = 0;
    [self resetEmitter:state];
    string = [NSString stringWithString:@"brush.png"];
    
}

-(void)pressButton2:(id)sender
{
    state = 1;
    [self resetEmitter:state];
    string = [NSString stringWithString:@"circle.png"];

}

-(void)pressButton3:(id)sender
{
    state = 2;
    [self resetEmitter:state];
    string = [NSString stringWithString:@"triangle.png"];
}

-(void)pressButton4:(id)sender
{
    state = 3;
    [self resetEmitter:state];
    string = [NSString stringWithString:@"square.png"];
}




-(void)setupPalette
{
    
    CCMenuItemImage *p1 = [CCMenuItemImage itemFromNormalImage:@"button1off.png" selectedImage:@"button1on.png" target:self selector:@selector(pressButton1:)];
    
    CCMenu *menu = [CCMenu menuWithItems:p1, nil];
    menu.anchorPoint = ccp(0.5,0.5);
    menu.position = ccp(64,640);
    [self addChild:menu z:2];
    
    CCMenuItemImage *p2 = [CCMenuItemImage itemFromNormalImage:@"button2off.png" selectedImage:@"button2on.png" target:self selector:@selector(pressButton2:)];
    
    CCMenu *menu2 = [CCMenu menuWithItems:p2, nil];
    menu2.position = ccp(64,512);
    [self addChild:menu2 z:2];
    
    CCMenuItemImage *p3 = [CCMenuItemImage itemFromNormalImage:@"button3off.png" selectedImage:@"button3on.png" target:self selector:@selector(pressButton3:)];
    
    CCMenu *menu3 = [CCMenu menuWithItems:p3, nil];
    menu3.position = ccp(64,384);
    [self addChild:menu3 z:2];
    
    CCMenuItemImage *p4 = [CCMenuItemImage itemFromNormalImage:@"button4off.png" selectedImage:@"button4on.png" target:self selector:@selector(pressButton4:)];
    
    CCMenu *menu4 = [CCMenu menuWithItems:p4, nil];
    menu4.position = ccp(64,256);
    [self addChild:menu4 z:2];
    
    
}


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    // get absolute screen location where touch occurred
    CGPoint pressLocation = [self convertTouchToNodeSpace:touch];
    
    [target begin];
    CCSprite *sprite = [CCSprite spriteWithFile:string];
    sprite.position = ccp(pressLocation.x, pressLocation.y);
    //[self addChild:sprite z:1];
    [sprite visit];
    [target end];
    
    return YES;
    
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
     
    //  CGSize wins = [[CCDirector sharedDirector] winSize];
    
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
    
    [target begin];
    CCSprite *sprite = [CCSprite spriteWithFile:string];
    sprite.position = ccp(convertedLocation.x, convertedLocation.y);
    //[self addChild:sprite z:1];
    [sprite visit];
    [target end];
    
    
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    
    [emitter release];
    [emitter2 release];
        
}
@end
