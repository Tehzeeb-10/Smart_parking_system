# Smart Parking Controller RTL

## Overview

The Smart Parking Controller is a Verilog RTL-based digital system designed to manage an 8-slot parking area.

The controller keeps track of the number of occupied parking slots and provides status signals for parking availability, full capacity, almost-full condition, vehicle entry, and vehicle exit.

## Features

* 8 parking slots
* Vehicle entry detection
* Vehicle exit detection
* Occupied slot counter
* Available slot counter
* Full parking detection
* Almost-full detection
* Entry permission control
* Exit permission control
* Overflow protection
* Underflow protection
* Simultaneous entry and exit handling
* Reset functionality

## Inputs

| Signal          | Description                       |
| --------------- | --------------------------------- |
| `clk`           | System clock                      |
| `reset`         | Active-high asynchronous reset    |
| `vehicle_entry` | Vehicle entering the parking area |
| `vehicle_exit`  | Vehicle leaving the parking area  |

## Outputs

| Signal                | Description                                |
| --------------------- | ------------------------------------------ |
| `occupied_count`      | Number of occupied slots                   |
| `slots_available`     | Number of available slots                  |
| `parking_full`        | Indicates all 8 slots are occupied         |
| `parking_almost_full` | Indicates 7 slots are occupied             |
| `entry_allowed`       | Indicates whether vehicle entry is allowed |
| `exit_allowed`        | Indicates whether vehicle exit is possible |

## Operation

* When a vehicle enters, the occupied count increases by 1.
* When a vehicle exits, the occupied count decreases by 1.
* Entry is blocked when the parking area is full.
* Exit is blocked when the parking area is empty.
* When both entry and exit occur simultaneously, there is no net change in occupancy.
* Reset clears the occupied count to zero.

## Verification

The design was simulated using **Icarus Verilog**.

The following cases were verified:

* Reset
* Vehicle entry
* Almost-full condition
* Full capacity
* Overflow protection
* Vehicle exit
* Simultaneous entry and exit
* Empty parking
* Underflow protection

All functional test cases passed successfully.

## Tools Used

* Verilog/SystemVerilog
* Icarus Verilog
* EPWave
* EDA Playground
* GitHub

## Project Structure

```text
smart-parking-controller-rtl/
├── rtl/
│   └── smart_parking_controller.sv
├── simulation/
│   └── testbench.sv
├── waveform/
│   └── simulation_waveform.png
├── report/
│   └── project_report.pdf
└── README.md
```

## Author

**Tehzeeb Thamis**

Electronics and Communication Engineering
