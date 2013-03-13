package traer.physics
{
	public interface Force
	{
		function turnOn():void;
		function turnOff():void;
		function isOn():Boolean;
		function isOff():Boolean;
		function apply():void;
	}
}