# Advanced Rocket Fuel Calculate 🚀

## Overview
This repository contains an advanced MATLAB script for simulating the 1-dimensional vertical ascent of a rocket. Moving beyond basic static calculations, this script uses MATLAB's numerical ODE solver (`ode45`) to model the dynamic physics of a rocket launch. It continuously tracks the rocket's altitude, velocity, and decreasing mass as propellant is consumed during flight.

## Key Features
* **Dynamic Mass Depletion:** Implements the core principles of the Tsiolkovsky Rocket Equation, updating the rocket's mass in real-time as fuel is burned, which results in increasing acceleration.
* **Aerodynamic Drag:** Calculates air resistance using an exponential atmospheric model, where air density naturally decreases as the rocket gains altitude.
* **Variable Gravity:** Adjusts the gravitational pull dynamically based on the distance from the center of the Earth.
* **Automated MECO (Main Engine Cut-Off):** Automatically detects when the propellant is fully depleted and cuts off thrust, allowing the rocket to coast on inertia.
* **Data Visualization:** Automatically plots clean, multi-subplot graphs displaying Altitude, Velocity, and Mass over time.

## Prerequisites
* **MATLAB:** The script is written in base MATLAB. No additional or specialized toolboxes (like the Aerospace Toolbox) are required to run this simulation.

## Usage
1. Download or clone this repository.
2. Open `advanced_rocket_simulation.m` in MATLAB.
3. (Optional) Modify the initial parameters in the `p` structure to match your specific rocket's specifications. 
4. Run the script.

### Customizable Parameters
You can easily tweak the following parameters at the top of the script to simulate different types of launch vehicles:
* `p.thrust_kN`: Engine thrust in kiloNewtons (kN)
* `p.Isp`: Specific impulse in seconds (s)
* `p.m_initial`: Total mass of the rocket at liftoff in kilograms (kg)
* `p.m_propellant`: Mass of the onboard fuel/propellant in kilograms (kg)
* `p.Cd`: Drag coefficient
* `p.A`: Cross-sectional area of the rocket in square meters (m²)

## Output
When executed, the script provides two outputs:

1. **Command Window Log:**
   Prints the calculated mass flow rate, theoretical fuel consumption per hour, actual engine burn time, and the exact altitude and velocity at the moment of engine cut-off.

2. **Flight Data Graphs:**
   Generates a figure with three subplots tracking the rocket's performance from $T=0$ to $T=200$ seconds, complete with a red dashed line indicating the exact moment of Main Engine Cut-Off.

## License
This project is open-source and available under the MIT License. Feel free to fork, modify, and expand upon this simulation!# Rocket_Fuel_Calculate
