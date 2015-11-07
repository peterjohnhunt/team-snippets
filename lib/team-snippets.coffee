TeamSnippetsView = require './team-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = TeamSnippets =
  teamSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @teamSnippetsView = new TeamSnippetsView(state.teamSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @teamSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'team-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @teamSnippetsView.destroy()

  serialize: ->
    teamSnippetsViewState: @teamSnippetsView.serialize()

  toggle: ->
    console.log 'TeamSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
