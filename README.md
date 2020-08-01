# DRIVE: Digital Twin for self-dRiving Intelligent VEhicles

DRIVE is an open-source framework for experimenting with large-scale heterogeneous communication scenarios. It is designed to be easily configurable and able to reduce the computational complexity of the existing simulation frameworks, still providing a very realistic representation of the real-world.

A detailed description about the capabilities of DRIVE simulation framework, as well information about how to use it can be found in the [User Manual](https://github.com/ioannismavromatis/smarterSimulator/blob/master/userManualDRIVE.pdf) provided by this repository.

## DRIVE At-a-Glance

DRIVE is capable of using real-world maps downloaded from [OpenStreetMap](https://www.openstreetmap.org/), manipulating the buildings and foliage in such a way that the execution time is minimised, without though losing from the realism provided from traditional simulation frameworks. On top of that, it provides a bidirectional connection with [SUMO traffic generator](https://www.dlr.de/ts/en/desktopdefault.aspx/tabid-9883/16931_read-41000/), via [Traffic Control Interface (TraCI)](https://sumo.dlr.de/wiki/TraCI) in a server-client fashion. By that, vehicles and pedestrian mobility traces can be generated and utilised for experimentation with mobile nodes. In alignment with the SUMO mobility traces, indoor user traffic introduced per building block that contributes to the overall network load.

DRIVE can be used for investigating different communication-related problems, such as optimising the basestation placement and switch-on-switch-off approaches on the deployed basestations, heterogeneous resource allocation techniques, efficient content dissemination and fetching, quality-of-service centric optimisation as perceived from the system-level perspective, etc. All the above problems can be tackled from both the indoor user, as well as the Vehicle-to-Everything (V2X) perspective.

The framework is designed in such a way to be highly parallelised and vectorised. Therefore, the execution time is minimised making it a great tool for developing AI- and Machine Learning algorithms for the above-mentioned problems. Of course, traditional optimisation algorithms can be used in a similar fashion. This framework, being designed in MATLAB, can be very easily linked with the existing optimisation and Machine-learning toolboxes provided by MathWorks. However, the MATLAB implementation does not limit the end-user to use machine-learning algorithms on different programming languages as well. For example, [this link](https://uk.mathworks.com/products/matlab/matlab-and-python.html) describes how Python libraries can be called from within MATLAB.

License
------------
This code is freely available under the terms of the license found in the [LICENCE](https://github.com/ioannismavromatis/DRIVE_Simulator/blob/master/LICENSE) file.\
If this code is used for drafting a manuscript, all we ask is to cite the following papers:
```    
@inproceedings{driveSimulator
    author={{Mavromatis}, I. and {Piechocki}, R. and {Sooriyabandara}, M. and {Parekh}, A.},
    booktitle={Proc. of IEEE Symposium on Computers and Communications (ISCC)},
    title={{DRIVE: A Digital Network Oracle for Cooperative Intelligent Transportation Systems}},
    year={2020},
    month={jul},
}
```

## This repository contains:

* DRIVE code.
* DRIVE [Licence](https://github.com/ioannismavromatis/smarterSimulator/blob/master/LICENSE).
* DRIVE [User Manual](https://github.com/ioannismavromatis/smarterSimulator/blob/master/userManualDRIVE.pdf).
* Three example use-cases, demonstrating the different functionalities of DRIVE:
    * A scenario based on just an OSM map, simulating indoor traffic and a macro-cell communication plane that calculates the average datarate for the given technology.
    * A scenario with both indoor traffic and SUMO mobility traces, that changes the configuration of the given communication planes based on the user density.
	* A scenario that calculates the number of established links between vehicles and pedestrians, in a Vehicle-to-Vehicle and Pedestrian-to-Pedestrian fashion.
* Two example maps extracted from [OpenStreetMap](https://www.openstreetmap.org/), with their corresponding mobility traces, generated using [SUMO traffic generator](https://www.dlr.de/ts/en/desktopdefault.aspx/tabid-9883/16931_read-41000/). Also, one more example generated using netgenerate SUMO tool.
    * Manhattan -- ~9km<sup>2</sup> of buildings, foliage and roads, with vehicular (2 different types of vehicles) and pedestrian mobility traces generated.
    * London -- ~4km<sup>2</sup> of buildings, foliage and roads, with vehicular (2 types of vehicles) mobility traces generated.
    * Smart Junction -- A cross-junction (one lane per road), and with the corresponding vehicular (2 types of vehicles) mobility traces generated. 

## Useful Links

* OpenStreetMap [Website](https://www.openstreetmap.org/) and [map exporting online tool](https://www.openstreetmap.org/export).
* SUMO Traffic Generator: [User Documentation](https://sumo.dlr.de/wiki/SUMO_User_Documentation) and [download links/installation instructions](https://sumo.dlr.de/userdoc/Downloads.html).
* TraCI4Matlab [link](https://github.com/pipeacosta/traci4matlab) and [installation instructions](https://github.com/pipeacosta/traci4matlab/blob/master/user_manual.pdf).
