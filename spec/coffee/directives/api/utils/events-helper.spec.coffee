describe 'uiGmapEventsHelper', ->
  scope = null
  beforeEach ->
    module 'uiGmapgoogle-maps.directives.api.utils'
    module 'uiGmapgoogle-maps.mocks'
    @injects.push ['uiGmapEventsHelper', 'GoogleApiMock', (EventsHelper, GoogleApiMock) =>
      @subject = EventsHelper
      @gmap = new GoogleApiMock()
      @gmap.mockAPI()
      @listeners = @gmap.mockEvent()
    ]
    @injectAll()

    scope =
      events:
        click: ->
      $evalAsync: (arg) ->
        return
  it 'exists', ->
    expect(@subject).toBeDefined()

  describe 'setEvents', ->
    it 'function exists', ->
      expect(@subject.setEvents).toBeDefined()

    it 'add events', ->
      spyOn scope.events, 'click'
      @subject.setEvents @, scope, 'model'
      window.google.maps.event.fireListener @, 'click'
      expect(scope.events.click).toHaveBeenCalled()

  describe 'removeEvents', ->
    it 'function exists', ->
      expect(@subject.removeEvents).toBeDefined()

    it 'removes the listeners', ->
      listeners = @subject.setEvents @, scope, 'model'
      expect(@listeners.length).toBe(1)
      @subject.removeEvents @listeners
      expect(@listeners.length).toBe(0)
