package;

import player.Player;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.system.debug.Window;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Hud extends FlxTypedGroup<FlxSprite> {

    var player:Player;
    var background:FlxSprite;
    var livesSprite:FlxSprite;
    var livesCounter:FlxText;
    var scoreLabel:FlxText;
    var scoreCounter:FlxText;
    var score:Int;

    public function new(player_:Player, ?textSize:Int=16, ?spriteSize:Int=32)
    {
        super();

        player = player_;
        score = 0;

        //Transparent black
        background = new FlxSprite(0, FlxG.height * 0.9).makeGraphic(FlxG.width, Std.int(FlxG.height / 10), 0x55000000);

        var spriteHeight:Float = FlxG.height - background.height;
        //var textHeight:Float = (background.height - textSize) / 2;
        var textHeight:Float = FlxG.height - background.height;
        var textOffset:Float = spriteSize / 2;

        livesSprite = makeSprite(livesSprite, AssetPaths.heart__png, FlxG.width / 100, spriteHeight, spriteSize);
        livesCounter = new FlxText(livesSprite.x + livesSprite.width + textOffset, textHeight, 0, "" + player.health, textSize);
        livesCounter.color = FlxColor.RED;
        livesCounter.scrollFactor.set(0, 0);


        scoreLabel = new FlxText(livesSprite.x + livesSprite.width + (textOffset * 4), textHeight, "Score: ", textSize); 
        scoreCounter = new FlxText(scoreLabel.x + scoreLabel.width + textOffset, textHeight, 0, "" + score, textSize);
        scoreCounter.scrollFactor.set(0, 0);

        add(background);
        add(livesSprite);
        add(livesCounter);
        add(scoreCounter);
        add(scoreLabel);

    }

    override public function update(elapsed:Float)
    {
        setLivesText();
    }

    private function makeSprite(sprite:FlxSprite, assetPath:String, spriteX:Float, spriteHeight:Float, spriteSize:Int)
    {
        sprite = new FlxSprite(0, 0, assetPath);
        sprite.setGraphicSize(spriteSize, spriteSize);
        sprite.updateHitbox();
        sprite.setPosition(spriteX, spriteHeight);
        sprite.scrollFactor.set(0, 0);
        return sprite;
    }

    public function addScore(score:Int)
    {
        this.score += score;
        scoreCounter.text = "" + this.score;
    }

    public function removeScore()
    {
        this.score = 0;
        scoreCounter.text = "" + this.score;
    }

    public function setLivesText()
    {
        livesCounter.text = "" + player.health;
        
    }
}
