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

## Simulation Results

The Smart Parking Controller was successfully simulated using Icarus Verilog and the waveform was observed using EPWave.

### 1. Reset Phase — 0 ns to 20 ns

* `reset` is held high (`1`).
* `occupied_count` is initialized to `0`.
* `slots_available` is `8` (`1000` in binary).
* `entry_allowed` is `1`.
* `exit_allowed` is `0`.

### 2. Entry and Increment Phase — 20 ns to 160 ns

Vehicle entry pulses increment the occupancy count sequentially:

```text
0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8
```

At the same time, available slots decrease from `8` to `0`.

`exit_allowed` becomes `1` after the first vehicle enters.

### 3. Almost-Full Warning — Approximately 140 ns

When `occupied_count` reaches `7`:

* `parking_almost_full = 1`
* `slots_available = 1`

This indicates that only one parking slot remains.

### 4. Full Capacity — 160 ns to 200 ns

When `occupied_count` reaches `8`:

* `parking_full = 1`
* `slots_available = 0`
* `entry_allowed = 0`

The parking area is completely occupied.

### 5. Overflow Protection — Approximately 180 ns

An additional vehicle-entry pulse is applied while the parking area is full.

The controller ignores the entry request:

```text
occupied_count = 8
```

Therefore, the counter does not overflow.

### 6. Exit and Decrement Phase — 200 ns to 340 ns

Vehicle exit pulses decrement the occupancy count:

```text
8 → 7 → 6 → 5 → 4 → 3 → 2 → 1 → 0
```

As vehicles leave:

* `parking_full` returns to `0`.
* `parking_almost_full` returns to `0`.
* `entry_allowed` returns to `1`.

### 7. Underflow Protection — After 340 ns

When the parking area becomes empty:

* `occupied_count = 0`
* `exit_allowed = 0`

Any further vehicle-exit request is ignored, preventing the counter from becoming negative.

### Result

All major functional conditions were successfully verified:

* Reset operation
* Vehicle entry
* Occupancy counting
* Almost-full detection
* Full-capacity detection
* Overflow protection
* Vehicle exit
* Empty parking detection
* Underflow protection

The simulation waveform confirms that the Smart Parking Controller operates as expected.


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
│   └── waveform.png
├── report/
│   └── smart parking system report1.pdf
└── README.md
```

## Author

**Tehzeeb Thamis**

Electronics and Communication Engineering
