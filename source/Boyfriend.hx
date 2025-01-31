package;

class Boyfriend extends Character {
	public function new(x:Float, y:Float, ?char:String = 'bf') {
		super(x, y, char, true);
	}

	override function update(elapsed:Float) {
		if (!debugMode) {
			if (animation.curAnim.name.startsWith('sing')) {
				holdTimer += elapsed;
			}
			else
				holdTimer = 0;

			if (animation.curAnim.name.endsWith('miss') && animation.curAnim.finished && !debugMode) {
				playAnim('idle', true, false, 10);
			}
		}

		super.update(elapsed);
	}
}
