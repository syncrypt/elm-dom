module Dom exposing (..)

{-| This package provides tasks and synchronous functions (which returns tasks)
for querying and manipulating the DOM.

# Models
@docs Selector, Position, Dimensions

# Errors
@docs Error

# Scroll
@docs setScrollLeft, setScrollLeftSync, setScrollTop, setScrollTopSync
@docs getScrollLeft, getScrollLeftSync, getScrollTop, getScrollTopSync
@docs scrollIntoView, scrollIntoViewSync

# Value
@docs setValue, setValueSync, getValue, getValueSync

# Focus
@docs blur, blurSync, focus, focusSync, hasFocusedElement, hasFocusedElementSync

# Dimensions
@docs getDimensions, getDimensionsSync, isOver

# Selection
@docs select, selectSync

# Miscellaneous
@docs idSelector
-}

import Task exposing (Task)
import Native.Dom


{-| All functions loop up elmements with a selector, which is just an
alias for string.
-}
type alias Selector =
  String


{-| Represents a point in the screen. Top and left are used (instead of x and y
) because they are used by CSS.
-}
type alias Position =
  { left : Int
  , top : Int
  }


{-| Represents an elements bounding box and dimensions. This structure matches
[`Element.getBoundingClientRect`](https://developer.mozilla.org/en/docs/Web/API/Element/getBoundingClientRect).
-}
type alias Dimensions =
  { height : Float
  , bottom : Float
  , width : Float
  , right : Float
  , left : Float
  , top : Float
  }


{-| These are the types of errors that can occur when using these functions.

  * ElementNotFound - If no element is found with the given selector
  * InvalidSelector - If the given selector is invalid
  * TextNotSelectable - If select called on not an input or a textarea
-}
type Error
  = ElementNotFound Selector
  | InvalidSelector Selector
  | TextNotSelectable Selector


{-| Creates an ID (attribute) selector from the given string.

    selector = Dom.idSelector "container"
    -- [id='container']
-}
idSelector : String -> Selector
idSelector value =
  "[id='" ++ value ++ "']"



--- QUERYING ----


{-| Tests if the given position is over any element that matches the given
selector. It uses the [`document.elementFromPoint`](https://developer.mozilla.org/en-US/docs/Web/API/Document/elementFromPoint)
api, along with [`Element.matches`](https://developer.mozilla.org/en-US/docs/Web/API/Element/matches).

    isOverContainer = Dom.isOver '#container' { top = 10, left = 10 }
    -- Ok True

The JavaScript equivalent of the code above:

    var element = document.elementFromPoint(position.left, position.top)
    element.matches('#container, #container *')

*This does not force layout / reflow.*
-}
isOver : String -> Position -> Result Error Bool
isOver selector position =
  Native.Dom.isOver selector position



---- FOCUS / BLUR ----


{-| Returns a task that focuses the given selector.
-}
focus : Selector -> Task Error ()
focus selector =
  Native.Dom.focus selector


{-| Focuses the given selector.
-}
focusSync : Selector -> Result Error ()
focusSync selector =
  Native.Dom.focusSync selector


{-| Returns a task that blurs the given selector.
-}
blur : Selector -> Task Error ()
blur selector =
  Native.Dom.blur


{-| Blurs the given selector.
-}
blurSync : Selector -> Result Error ()
blurSync selector =
  Native.Dom.blurSync


{-| Returns a tasks which returns true if there is a currently focued element,
false otherwise.
-}
hasFocusedElement : Task Never Bool
hasFocusedElement =
  Native.Dom.hasFocusedElement


{-| Returns true if there is a currently focued element,
false otherwise.
-}
hasFocusedElementSync : () -> Bool
hasFocusedElementSync _ =
  Native.Dom.hasFocusedElementSync



---- SELECTION ----


{-| Returns a task that selects all text in the given selector.
-}
select : Selector -> Task Error ()
select selector =
  Native.Dom.select selector


{-| Selects all text in the given selector.
-}
selectSync : Selector -> Result Error ()
selectSync selector =
  Native.Dom.selectSync selector



---- DIMENSIONS ----


{-| Returns a task that returns the dimensions for the element with given
selector.
-}
getDimensions : Selector -> Task Error Dimensions
getDimensions selector =
  Native.Dom.getDimensions selector


{-| Returns the dimensions for the element with given
selector.
-}
getDimensionsSync : Selector -> Result Error Dimensions
getDimensionsSync selector =
  Native.Dom.getDimensionsSync selector



---- SCROLL ----


{-| Returns a task that sets the horizontal scroll position of the element with
the given selector.
-}
setScrollLeft : Int -> Selector -> Task Error ()
setScrollLeft to selector =
  Native.Dom.setScrollLeft to selector


{-| Sets the horizontal scroll position of the element with the given selector.
-}
setScrollLeftSync : Int -> Selector -> Result Error ()
setScrollLeftSync to selector =
  Native.Dom.setScrollLeftSync to selector


{-| Returns a task that sets the vertical scroll position of the element with
the given selector.
-}
setScrollTop : Int -> Selector -> Task Error ()
setScrollTop to selector =
  Native.Dom.setScrollTop to selector


{-| Sets the vertical scroll position of the element with the given selector.
-}
setScrollTopSync : Int -> Selector -> Result Error ()
setScrollTopSync to selector =
  Native.Dom.setScrollTopSync to selector


{-| Returns a task that scrolls the parent elements of the given selector so
the the element with the given selector will be visible.
-}
scrollIntoView : Selector -> Task Error ()
scrollIntoView selector =
  Native.Dom.scrollIntoView selector


{-| Scrolls the parent elements of the given selector so the the element with
the given selector will be visible.
-}
scrollIntoViewSync : Selector -> Result Error ()
scrollIntoViewSync selector =
  Native.Dom.scrollIntoViewSync selector


{-| Returns a task that gets the horizontal scroll position of the element with
the given selector.
-}
getScrollLeft : Selector -> Task Error Int
getScrollLeft selector =
  Native.Dom.getScrollLeft selector


{-| Gets the horizontal scroll position of the element with the given selector.
-}
getScrollLeftSync : Selector -> Result Error Int
getScrollLeftSync selector =
  Native.Dom.getScrollLeftSync selector


{-| Returns a task that gets the vertical scroll position of the element with
the given selector.
-}
getScrollTop : Selector -> Task Error Int
getScrollTop selector =
  Native.Dom.getScrollTop selector


{-| Gets the vertical scroll position of the element with the given selector.
-}
getScrollTopSync : Selector -> Result Error Int
getScrollTopSync selector =
  Native.Dom.getScrollTopSync selector



---- GET / SET VALUE ----


{-| Returns a task that sets the value of the element with the given selector
to the given value.
-}
setValue : String -> Selector -> Task Error ()
setValue value selector =
  Native.Dom.setValue value selector


{-| Sets the value of the element with the given selector to the given value.
-}
setValueSync : String -> Selector -> Result Error ()
setValueSync value selector =
  Native.Dom.setValueSync value selector


{-| Returns a task that gets the value of an element with the given selector.
-}
getValue : Selector -> Result Error ()
getValue selector =
  Native.Dom.getValueSync selector


{-| Gets the value of an element with the given selector.
-}
getValueSync : Selector -> Result Error ()
getValueSync selector =
  Native.Dom.getValueSync selector



{-

   scrollIntoViewIfNeeded : Selector -> Task Error ()

   scrollIntoViewIfNeededSync : Selector -> Result Error ()

   ---- SELECTION ----

   setSelection : Int -> Int -> String -> Task Error ()

   setSelectionSync : Int -> Int -> String -> Task Error ()
-}
