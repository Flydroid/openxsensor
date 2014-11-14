// config file writing function

void writeConf() {

  boolean dataFirst = true ;

  output = createWriter( outputConfigDir );

  output.println("// Configuration file generated by OpenXsensor Configurator " + oxsCversion + " the: " + day + "-" + month + "-" + year() );
  output.println("// !! This file is only compatible with version " + oxsVersion + " of OpenXsensor !!");
  output.println("");
  output.println("// OpenXsensor https://code.google.com/p/openxsensor/");
  output.println("// started by Rainer Schloßhan");
  output.println("");
  output.println("//***********************************************************************************************************************");
  output.println("// Another file in this project (see oxs_config_description.h) provides detailed explanations on how to set up this file.");
  output.println("//***********************************************************************************************************************");
  output.println("");
  output.println("#ifndef OXS_CONFIG_h");
  output.println("#define OXS_CONFIG_h");
  output.println("");

  // ---------------------------------- Device id --------------------------------------

  output.println("// --------- 1 - FrSky device ID when Sport protocol is used ---------");
  output.println("#define SENSOR_ID    0x1B");
  output.println("");

  // ---------------------------------- Serial pin --------------------------------------

  output.println("// --------- 2 - Serial data pin choice ---------");
  output.println("#define PIN_SERIALTX    " + serialPin.captionLabel().getText() + "       // The pin which transmits the serial data to the FrSky telemetry enabled receiver");
  output.println("");
 
  // ---------------------------------- PPM --------------------------------------
  
  output.println("// --------- 3 - PPM settings ---------");
  if ( cp5.getController("vario").value() == 1 && cp5.getController("ppm").value() == 1 ) {
    output.println("#define PIN_PPM         " + ppmPin.captionLabel().getText() + "       // Arduino can read a PPM Signal coming from Tx. This allows to change the vario sensitivity using a pot or a switch on TX.");
  } else {
    output.println("//#define PIN_PPM               // Arduino can read a PPM Signal coming from Tx. This allows to change the vario sensitivity using a pot or a switch on TX.");
  }
  output.println("#define PPM_MIN_100     " + int(cp5.getController("ppmRngMin").getValue()) + "     // 1500 - 512 ; pulse width (usec) when TX sends a channel = -100");
  output.println("#define PPM_PLUS_100    " + int(cp5.getController("ppmRngMax").getValue()) + "    // 1500 + 512 ; pulse width (usec) when TX sends a channel = +100");
  output.println("");

  // ---------------------------------- Vario --------------------------------------

  output.println("// --------- 4 - Vario settings ---------");
  output.println("");
  output.println("// ***** 4.1 - Connecting 1 or 2 MS5611 barometric sensor *****");
  if ( cp5.getController("vario").value() == 1 ) {
    output.println("#define VARIO                   // set as comment if there is no vario");
    output.println("//#define VARIO2                // set as comment if there is no second vario");
  } else {
    output.println("//#define VARIO                 // set as comment if there is no vario");
    output.println("//#define VARIO2                // set as comment if there is no second vario");
  }
  output.println("");
  output.println("// ***** 4.2 - Sensitivity predefined by program *****");
  output.println("#define SENSITIVITY_MIN       " + int(cp5.getController("sensMinMax").getArrayValue(0)) );
  output.println("#define SENSITIVITY_MAX       " + int(cp5.getController("sensMinMax").getArrayValue(1)) );
  output.println("#define SENSITIVITY_MIN_AT    " + int(cp5.getController("vSpeedMin").getValue()) );
  output.println("#define SENSITIVITY_MAX_AT    " + int(cp5.getController("vSpeedMax").getValue()) );
  output.println("");
  output.println("// ***** 4.3 - Sensitivity adjusted from the TX *****");
  output.println("#define SENSITIVITY_MIN_AT_PPM    " + "10" + "   // sensitivity will be changed by OXS only when PPM signal is between the specified range enlarged by -5/+5");  // TODO: missing parameter from configurator
  output.println("#define SENSITIVITY_MAX_AT_PPM    " + "40");  // TODO: missing parameter from configurator
  output.println("#define SENSITIVITY_PPM_MIN       " + int(cp5.getController("ppmSensMinMax").getArrayValue(0)) + "   // common value for vario is 20");
  output.println("#define SENSITIVITY_PPM_MAX       " + int(cp5.getController("ppmSensMinMax").getArrayValue(1)) + "  // common value for vario is 100");
  output.println("");
  output.println("// ***** 4.4 - Hysteresis parameter *****");
  output.println("#define VARIOHYSTERESIS    " + int(cp5.getController("varioHysteresis").getValue()) );
  output.println("");
  output.println("// ***** 4.5 - Vertical speeds calculations *****");
  output.println("#define VARIO_PRIMARY              0    // 0 means first ms5611, 1 means second ms5611 , 2 means vario based on vario 1 + compensation from airspeed");
  output.println("#define VARIO_SECONDARY            0    // 0 means first ms5611, 1 means second ms5611 , 2 means vario based on vario 1 + compensation from airspeed");
  output.println("#define SWITCH_VARIO_MIN_AT_PPM    10");
  output.println("#define SWITCH_VARIO_MAX_AT_PPM    90");
  output.println("");
  output.println("// ***** 4.6 - Analog vertical speed *****");
  if ( cp5.getController("vario").value() == 1 && cp5.getController("analogClimb").value() == 1 ) {
    output.println("#define PIN_ANALOG_VSPEED    " + climbPin.captionLabel().getText() + "  // the pin used to write the vertical speed to the Rx A1 or A2 pin (can be 3 or 11 because it has to use timer 2)");
  } else {
    output.println("//#define PIN_ANALOG_VSPEED       //  the pin used to write the vertical speed to the Rx A1 or A2 pin (can be 3 or 11 because it has to use timer 2)");  
  }
  output.println("#define ANALOG_VSPEED_MIN    " + int(cp5.getController("outClimbRateMinMax").getArrayValue(0)) );
  output.println("#define ANALOG_VSPEED_MAX    " + int(cp5.getController("outClimbRateMinMax").getArrayValue(1)) );
  output.println("");
  
  // ---------------------------------- Air Speed --------------------------------------  // TODO
  
  output.println("// --------- 5 - Airspeed settings ---------");
  output.println("//#define AIRSPEED    MS4525");      // TODO
  output.println("");
  output.println("#define AIRSPEED_RESET_AT_PPM      100");
  output.println("");
  output.println("#define COMPENSATION_MIN_AT_PPM    60");
  output.println("#define COMPENSATION_MAX_AT_PPM    90");
  output.println("#define COMPENSATION_PPM_MIN       80");
  output.println("#define COMPENSATION_PPM_MAX       140");
  output.println("");

  // --------------------------- Voltages & Current sensor settings ---------------------------

  output.println("// --------- 6 - Voltages & Current sensor settings ---------");
  output.println("");
  output.println("// ***** 6.1 - Voltage Reference selection (VCC or 1.1V internal) *****");
  if ( cp5.getController("intRef").value() == 1 ) {
    output.println("#define USE_INTERNAL_REFERENCE    // Select the voltage reference, comment the line to activate the VCC voltage reference");
    output.println("//#define ARDUINOVCC              // Specify the VCC voltage of the arduino to correctly read ADC values");
  } else {
    output.println("//#define USE_INTERNAL_REFERENCE    // Select the voltage reference, uncomment the line to activate the internal 1.1v voltage reference");
    output.println("#define ARDUINOVCC             " + cp5.getController("arduinoVccNb").getValueLabel().getText() + "  // Specify the VCC voltage of the arduino to correctly read ADC values");
  }
  output.println("");
  output.println("// ***** 6.2 - Voltages Analog Pins *****");
  for ( int i = 1; i <= voltNbr; i++ ) {
    if ( cp5.getController( "voltage" ).value() == 1 && cp5.getController( "volt" + i ).value() == 1 && int(cp5.getGroup("ddlVolt" + i).getValue()) >= 0 ) {
      output.println("#define PIN_VOLTAGE_" + i + "    " + int(cp5.getGroup("ddlVolt" + i).getValue()) );
    } else {
      output.println("//#define PIN_VOLTAGE_" + i );
    }
  }
  output.println("");
  output.println("// ***** 6.3 - Voltage measurements calibration parameters *****");
  for ( int i = 1; i <= voltNbr; i++ ) {
    if ( cp5.getController( "voltage" ).value() == 1 && cp5.getController( "volt" + i ).value() == 1 ) {
      output.println("#define OFFSET_" + i + "             " + cp5.getController("offsetVolt" + i).getValueLabel().getText() + "                                        // offset in mv");
      if ( cp5.getController("intRef").value() == 0 ) {
        output.println("#define MVOLT_PER_STEP_" + i + "     ( ARDUINOVCC * 1000.0 / 1024.0 * " + cp5.getController("dividerVolt" + i ).getValueLabel().getText() + " )  // => last number is the divider factor");
      } else {
        output.println("#define MVOLT_PER_STEP_" + i + "     ( 1.1 * 1000.0 / 1024.0 * " + cp5.getController("dividerVolt" + i ).getValueLabel().getText() + " )  // => last number is the divider factor");
      }
    } else {
      output.println("#define OFFSET_" + i + "             " + 0 );
      output.println("#define MVOLT_PER_STEP_" + i + "     " + 1 );
    }
  }
  output.println("");
  output.println("// ***** 6.4 - Number of Lipo cells to measure (and transmit to Tx) *****");
  if ( cp5.getController( "voltage" ).value() == 1 && cp5.getController( "cells" ).value() == 1 ) {
    output.println("#define NUMBEROFCELLS    " + ( int(cp5.getGroup("ddlNbrCells").getValue()) ) );
  } else {
    output.println("//#define NUMBEROFCELLS");
  }
  output.println("");
  
  // ------------------------------ Current sensor ------------------------------ 
  
  output.println("// ***** 6.5 - Current sensor analog pin *****");
  if ( cp5.getController( "current" ).value() == 1 && int(cp5.getGroup("currentPin").getValue()) >= 0 ) {
    output.println("#define PIN_CURRENTSENSOR    " + ( int(cp5.getGroup("currentPin").getValue()) ) );
  } else {
    output.println("//#define PIN_CURRENTSENSOR");    
  }
  output.println("");
  output.println("// ***** 6.6 - Current sensor calibration parameters *****");
  output.println("#define OFFSET_CURRENT_STEPS         " + offsetCurrent() + "      // 66mv offset (set to zero for now)");
  output.println("#define MAMP_PER_STEP                " + round(mAmpStep(), 2) + "   // INA282 with 0.1 ohm shunt gives 5000mv/A ");
  output.println("");

  // ---------------------------- Temperature sensor ----------------------------

  if ( tempActive ) {
    if ( cp5.getController( "temperature" ).value() == 1 && int(cp5.getGroup("tempPin").getValue()) >= 0 ) {
     output.println("// -------- Temperature sensor --------");
     output.println("#define PIN_TemperatureSensor   " + ( int(cp5.getGroup("tempPin").getValue()) ) + "  // The Analog pin the optional temperature sensor is connected to");
     output.println("#define TEMPOFFSET              " + cp5.get(Textfield.class, "tempOffset").getText() + "  // Calibration offset");
     } else {
     //output.println("#define PIN_TemperatureSensor        // The Analog pin the optional temperature sensor is connected to");
     //output.println("#define TEMPOFFSET                   // Calibration offset");
     }
     output.println("");
  }
  
  // --------------------------------- RPM sensor ---------------------------------

  output.println("// --------- 7 - RPM (rotations per minute) settings ---------");
  if ( cp5.getController( "rpm" ).value() == 1 ) {    
    output.println("#define MEASURE_RPM") ;
  } else {
    output.println("//#define MEASURE_RPM") ;
  }
  output.println("");
  
  // ------------------------------ Save to EEPROM --------------------------------

  output.println("// --------- 8 - Persistent memory settings ---------");
  if ( cp5.getController("saveEprom").value() == 1 ) {
    output.println("#define SAVE_TO_EEPROM            // Some telemetry values will be stored in EEProm every 10 seconds.");
  } else {
    output.println("//#define SAVE_TO_EEPROM");
  }
  if ( cp5.getController("resetButton").value() == 1 && cp5.getGroup("resetButtonPin").getValue() != -1 ) {
    output.println("#define PIN_PUSHBUTTON       " + cp5.get(DropdownList.class, "resetButtonPin").captionLabel().getText() );
  } else {
    output.println("//#define PIN_PUSHBUTTON");
  }
  output.println("");

  // ------------------------- Transmitted data setting -------------------------

  output.println("// --------- 9 - Data to transmit ---------");
  output.println("// General set up to define which measurements are transmitted and how");
  output.println("");
  output.println("#define SETUP_DATA_TO_SEND    \\");
  for ( int i = 1; i <= dataSentFieldNbr; i++ ) {
    if ( cp5.getGroup("sentDataField" + i ).getValue() != 0 ) {
      if ( !dataFirst ) {
        output.println(" , \\");
      }
      if ( cp5.get(DropdownList.class, "sentDataField" + i ).captionLabel().getText().equals("Cells monitoring") ) {
        if ( cp5.getController("cells").getValue() == 1 ) {
          for ( int j = 1 ; j <= int( cp5.getGroup("ddlNbrCells").getValue() ) ; j += 2 ) {
            output.print("                        " + "DEFAULTFIELD , CELLS_" + j + "_" + ( j + 1 ) + " , 1 , 1 , 0" );
            if ( int( cp5.getGroup("ddlNbrCells").getValue() ) > ( j + 1 ) ) {
              output.println(" , \\");
            }
            dataFirst = false ;
          }
        }
      } else if ( cp5.getGroup("protocolChoice").getValue() == 1 ) {
        output.print("                        " + hubDataList[int(cp5.getGroup("hubDataField" + i ).getValue())][0] + " , "
          + sentDataList[int(cp5.getGroup("sentDataField" + i ).getValue())][0] + " , "
          + cp5.getController("dataMultiplier" + i).getValueLabel().getText() + " , "
          + cp5.getController("dataDivider" + i).getValueLabel().getText() + " , "
          + cp5.getController("dataOffset" + i).getValueLabel().getText() );
        dataFirst = false ;
      } else {
        output.print("                        " + sPortDataList[int(cp5.getGroup("sPortDataField" + i ).getValue())][0] + " , "
          + sentDataList[int(cp5.getGroup("sentDataField" + i ).getValue())][0] + " , "
          + cp5.getController("dataMultiplier" + i).getValueLabel().getText() + " , "
          + cp5.getController("dataDivider" + i).getValueLabel().getText() + " , "
          + cp5.getController("dataOffset" + i).getValueLabel().getText() );
        dataFirst = false ;
      }
    }
  }
  output.println("");
  output.println("");

  // ---------------------------------- Debug --------------------------------------

  output.println("// --------- 10 - Reserved for developer. DEBUG must be activated here when we want to debug one or several functions in some other files. ---------");
  output.println("//#define DEBUG");
  output.println("");
  output.println("#ifdef DEBUG");
  output.println("#include \"HardwareSerial.h\"");
  output.println("#endif");
  output.println("");

  // ---------------------------------- The end --------------------------------------

  output.print("#endif// End define OXS_CONFIG_h");

  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file

    //exit(); // Stops the program
}
