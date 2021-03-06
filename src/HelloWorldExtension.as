package 
{
	import flash.display.Sprite;
	
	import core.app.CoreApp;
	import core.app.resources.FactoryResource;
	import core.appEx.entities.KeyModifier;
	import core.appEx.resources.CommandHandlerFactory;
	import core.appEx.resources.FileType;
	import core.appEx.resources.KeyBinding;
	import core.appEx.validators.ContextSelectionValidator;
	import core.appEx.validators.ContextValidator;
	import core.editor.CoreEditor;
	import core.editor.core.IGlobalViewContainer;
	import core.editor.entities.Commands;
	import core.editor.icons.CoreEditorIcons;
	import core.editor.resources.ActionFactory;
	import core.editor.resources.EditorFactory;
	
	import helloWorld.commandHandlers.AddStringCommandHandler;
	import helloWorld.commandHandlers.DeleteStringCommandHandler;
	import helloWorld.commandHandlers.MyCommandHandler;
	import helloWorld.contexts.HelloWorldContext;
	import helloWorld.contexts.StringListContext;
	import helloWorld.entities.Commands;
	
	public class HelloWorldExtension extends Sprite
	{
		public function HelloWorldExtension()
		{
			CoreApp.resourceManager.addResource( new FactoryResource( HelloWorldContext, "Hello World" ) );
			CoreApp.resourceManager.addResource( new EditorFactory( StringListContext, "String List", "strlist", CoreEditorIcons.Text ) );
			
			CoreApp.resourceManager.addResource( new ActionFactory( IGlobalViewContainer, helloWorld.entities.Commands.MY_COMMAND, "My Action", "myActions", "Actions/myActions", CoreEditorIcons.Resource ) );
			CoreApp.resourceManager.addResource( new ActionFactory( StringListContext, helloWorld.entities.Commands.ADD_STRING, "Add String", "myActions" ) );
			
			CoreApp.resourceManager.addResource( new KeyBinding( helloWorld.entities.Commands.MY_COMMAND, 77, KeyModifier.CTRL ) );
			
			CoreApp.resourceManager.addResource( new CommandHandlerFactory( helloWorld.entities.Commands.MY_COMMAND, MyCommandHandler ) );
			var commandHandlerFactory:CommandHandlerFactory = new CommandHandlerFactory( helloWorld.entities.Commands.ADD_STRING, AddStringCommandHandler );
			commandHandlerFactory.validators.push( new ContextValidator( CoreEditor.contextManager, StringListContext ) );
			CoreApp.resourceManager.addResource( commandHandlerFactory );
			
			commandHandlerFactory = new CommandHandlerFactory( core.editor.entities.Commands.DELETE, DeleteStringCommandHandler );
			commandHandlerFactory.validators.push( new ContextSelectionValidator( CoreEditor.contextManager, StringListContext, String ) );
			CoreApp.resourceManager.addResource( commandHandlerFactory );
			
			CoreApp.resourceManager.addResource( new FileType( "String List File", "strlist", CoreEditorIcons.Text ) );
		}
	}
}