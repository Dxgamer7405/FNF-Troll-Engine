package funkin.data;

class FreeplayOption {
	public var song:Song;

	public var name:String = "Song Name";
	public var iconId:String = "face";
	public var bgColor:Int = 0xFFFFFFFF;
	public var bgGraphic:String = "menuDesat";

	public function new(song:Song) {
		this.song = song;
	}

	public function getCharts():Array<String> {
		return song.charts;
	}

	public function play(chartId:String) {
		song.play(chartId);
	}
}