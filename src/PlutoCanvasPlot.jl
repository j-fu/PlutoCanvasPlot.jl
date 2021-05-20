module PlutoCanvasPlot

using UUIDs


include("api.jl")
include("internals.jl")

export command!
export CanvasPlot,  polygon!,linecolor!, fillcolor!
export textcolor!,textsize!,text!
export polyline!,linecolor!
export polygon!,fillcolor!
export axis!


end # module
