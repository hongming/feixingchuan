/*
 * MIT License
 *
 * Copyright (c) 2018-2021 Erriez
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/*!
 * \brief Serial Terminal getting started example
 * \details
 *      Source:         https://github.com/Erriez/ErriezSerialTerminal
 *      Documentation:  https://erriez.github.io/ErriezSerialTerminal
 */

#include <ErriezSerialTerminal.h>

// LED pin
#define LED_PIN     13

//TKS-M8S01-A
#define A_K1_PIN 11
#define A_K2_PIN 10
#define A_SW1_PIN 9
#define A_SW2_PIN 8

//TKS-M8S01-B
#define B_K1_PIN 7
#define B_K2_PIN 6
#define B_SW1_PIN 5
#define B_SW2_PIN 4

// Newline character '\r' or '\n'
char newlineChar = '\n';
// Separator character between commands and arguments
char delimiterChar = ' ';

// Create serial terminal object
SerialTerminal term(newlineChar, delimiterChar);

// Function prototypes
void unknownCommand(const char *command);
void cmdHelp();
void cmdLedOn();
void cmdLedOff();
void cmdPrintHello();
void cmdPrintIntArgument();
void cmdPrintStringArguments();
void cmdCloseA();
void cmdOpenA();
void cmdVccOffA();
void cmdCloseB();
void cmdOpenB();
void cmdVccOffB();
void cmdCloseAB();
void cmdOpenAB();
void comVccOffAB();
void cmdCloseAOpenB();
void cmdOpenACloseB();

void setup()
{
    // Startup delay to initialize serial port
    delay(500);

    // Initialize serial port
    Serial.begin(9600);
    Serial.println(F("\nSerial terminal example."));
    Serial.println(F("Type 'help' to display usage."));

    // Initialize the built-in LED
    pinMode(LED_PIN, OUTPUT);
    digitalWrite(LED_PIN, LOW);

    // Initialize the TKS-M8S01-A
    pinMode(A_K1_PIN, OUTPUT);
    digitalWrite(A_K1_PIN, HIGH);

    pinMode(A_K2_PIN, OUTPUT);
    digitalWrite(A_K2_PIN, HIGH);

    pinMode(A_SW1_PIN, OUTPUT);
    digitalWrite(A_SW1_PIN, HIGH);

    pinMode(A_SW2_PIN, OUTPUT);
    digitalWrite(A_SW2_PIN, HIGH);


    // Initialize the TKS-M8S01-B
    pinMode(B_K1_PIN, OUTPUT);
    digitalWrite(B_K1_PIN, HIGH);

    pinMode(B_K2_PIN, OUTPUT);
    digitalWrite(B_K2_PIN, HIGH);

    pinMode(B_SW1_PIN, OUTPUT);
    digitalWrite(B_SW1_PIN, HIGH);

    pinMode(B_SW2_PIN, OUTPUT);
    digitalWrite(B_SW2_PIN, HIGH);
 

    
    // Set default handler for unknown commands
    term.setDefaultHandler(unknownCommand);

    // Add command callback handlers
    term.addCommand("?", cmdHelp);
    term.addCommand("help", cmdHelp);
    term.addCommand("on", cmdLedOn);
    term.addCommand("off", cmdLedOff);
    term.addCommand("hello", cmdPrintHello);
    term.addCommand("i", cmdPrintIntArgument);
    term.addCommand("s", cmdPrintStringArguments);
    term.addCommand("closea", cmdCloseA);
    term.addCommand("opena", cmdOpenA);
    term.addCommand("cuta", cmdVccOffA);
    term.addCommand("closeb", cmdCloseB);
    term.addCommand("openb", cmdOpenB);
    term.addCommand("cutb", cmdVccOffB);
    term.addCommand("closeab", cmdCloseAB);
    term.addCommand("openab", cmdOpenAB);
    term.addCommand("caob", cmdCloseAOpenB);
    term.addCommand("oacb", cmdOpenACloseB);
    term.addCommand("cutab", cmdVccOffAB);

    // Default status:TSA A & B ALL POWER OFF.
    digitalWrite(A_K1_PIN, HIGH);
    digitalWrite(A_K2_PIN, HIGH);
    digitalWrite(A_SW1_PIN, LOW);
    digitalWrite(A_SW2_PIN, LOW);
    digitalWrite(B_K1_PIN, HIGH);
    digitalWrite(B_K2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, LOW);
    digitalWrite(B_SW2_PIN, LOW);
    Serial.println(F("@A & @B Panel READY!"));
}

void loop()
{
    // Read from serial port and handle command callbacks
    term.readSerial();
}

void unknownCommand(const char *command)
{
    // Print unknown command
    Serial.print(F("Unknown command: "));
    Serial.println(command);
}

void cmdHelp()
{
    // Print usage
    Serial.println(F("Serial terminal usage:"));
    Serial.println(F("  help or ?          Print this usage"));
    Serial.println(F("  on                 Turn LED on"));
    Serial.println(F("  off                Turn LED off"));
    Serial.println(F("  closeab                Close @A &@B Panel"));
    Serial.println(F("  openab                Open @A & @B Panel"));
    Serial.println(F("  cutab                Power OFF @A & @B Panel"));
    Serial.println(F("  closea                Close @A Panel"));
    Serial.println(F("  opena                Open @A Panel"));
    Serial.println(F("  cuta                Power OFF @A Panel"));
    Serial.println(F("  closeb                Close @B Panel"));
    Serial.println(F("  openb                Open @B Panel"));
    Serial.println(F("  cutb                Power OFF @B Panel"));
    Serial.println(F("  caob                Close @A and Open @B Panel"));
    Serial.println(F("  oacb                Open @A and Close @B Panel"));
    Serial.println(F("  hello [name] [age] Print your name and age"));
    Serial.println(F("  s <arg 1>..<arg N> Print string arguments"));
    Serial.println(F("  i <arg>            Print decimal or hex argument"));
}

void cmdLedOn()
{
    // Turn LED on
    Serial.println(F("LED on"));
    digitalWrite(LED_PIN, HIGH);
}

void cmdLedOff()
{
    // Turn LED off
    Serial.println(F("LED off"));
    digitalWrite(LED_PIN, LOW);
}



void cmdCloseA()
{
    //Close @A Panel
    digitalWrite(A_SW1_PIN, HIGH);
    digitalWrite(A_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Close @A Panel"));
    digitalWrite(A_K1_PIN, HIGH);
    digitalWrite(A_K2_PIN, LOW);

}

void cmdOpenA()
{
    //Open @A Panel
    digitalWrite(A_SW1_PIN, HIGH);
    digitalWrite(A_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Open @A Panel"));
    digitalWrite(A_K1_PIN, LOW);
    digitalWrite(A_K2_PIN, HIGH);

}

void cmdVccOffA()
{
    //Open @A Panel
    Serial.println(F("Power OFF @A Panel"));
    digitalWrite(A_K1_PIN, HIGH);
    digitalWrite(A_K2_PIN, HIGH);
    digitalWrite(A_SW1_PIN, LOW);
    digitalWrite(A_SW2_PIN, LOW);
}

void cmdCloseB()
{
    //Close @B Panel
    digitalWrite(B_SW1_PIN, HIGH);
    digitalWrite(B_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Close @B Panel"));
    digitalWrite(B_K1_PIN, HIGH);
    digitalWrite(B_K2_PIN, LOW);
}


void cmdOpenB()
{
    //Open @B Panel
    digitalWrite(B_SW1_PIN, HIGH);
    digitalWrite(B_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Open @B Panel"));
    digitalWrite(B_K1_PIN, LOW);
    digitalWrite(B_K2_PIN, HIGH);
}

void cmdVccOffB()
{
    //Open @B Panel
    Serial.println(F("Power OFF @B Panel"));
    digitalWrite(B_K1_PIN, HIGH);
    digitalWrite(B_K2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, LOW);
    digitalWrite(B_SW2_PIN, LOW);
}


void cmdCloseAB()
{
    //Close @A & @B Panel
    digitalWrite(A_SW1_PIN, HIGH);
    digitalWrite(A_SW2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, HIGH);
    digitalWrite(B_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Close @A & @B Panel"));
    digitalWrite(A_K1_PIN, HIGH);
    digitalWrite(A_K2_PIN, LOW);
    digitalWrite(B_K1_PIN, HIGH);
    digitalWrite(B_K2_PIN, LOW);
}


void cmdOpenAB()
{
    //Open @A & @B Panel
    digitalWrite(A_SW1_PIN, HIGH);
    digitalWrite(A_SW2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, HIGH);
    digitalWrite(B_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Open @A & @B Panel"));
    digitalWrite(A_K1_PIN, LOW);
    digitalWrite(A_K2_PIN, HIGH);
    digitalWrite(B_K1_PIN, LOW);
    digitalWrite(B_K2_PIN, HIGH);
}


void cmdCloseAOpenB()
{
    //Close @A Panel & Open @B Panel
    digitalWrite(A_SW1_PIN, HIGH);
    digitalWrite(A_SW2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, HIGH);
    digitalWrite(B_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Close @A Panel & Open @B Panel"));
    digitalWrite(A_K1_PIN, HIGH);
    digitalWrite(A_K2_PIN, LOW);
    digitalWrite(B_K1_PIN, LOW);
    digitalWrite(B_K2_PIN, HIGH);
}

void cmdOpenACloseB()
{
    //Open @A Panel & Close @B Panel
    digitalWrite(A_SW1_PIN, HIGH);
    digitalWrite(A_SW2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, HIGH);
    digitalWrite(B_SW2_PIN, HIGH);
    delay(500);
    Serial.println(F("Open @A Panel & Close @B Panel"));
    digitalWrite(A_K1_PIN, LOW);
    digitalWrite(A_K2_PIN, HIGH);
    digitalWrite(B_K1_PIN, HIGH);
    digitalWrite(B_K2_PIN, LOW);
}

void cmdVccOffAB()
{
    //Cut off Power @A & @B Panel
    Serial.println(F("Power OFF @A & @B Panel"));
    digitalWrite(A_K1_PIN, HIGH);
    digitalWrite(A_K2_PIN, HIGH);
    digitalWrite(A_SW1_PIN, LOW);
    digitalWrite(A_SW2_PIN, LOW);
    digitalWrite(B_K1_PIN, HIGH);
    digitalWrite(B_K2_PIN, HIGH);
    digitalWrite(B_SW1_PIN, LOW);
    digitalWrite(B_SW2_PIN, LOW);
}

void cmdPrintHello()
{
    char *arg;
    char *name = NULL;
    int age = 0;

    // Get first argument
    arg = term.getNext();
    if (arg != NULL) {
        // Try to convert argument to int
        if (atoi(arg)) {
            // Name is not specified
            // Convert age string to int
            age = atoi(arg);
        } else {
            // Store first name argument
            name = arg;

            // Get second age argument
            arg = term.getNext();

            // Convert age string to int
            age = atoi(arg);
        }
    }

    // Print name
    if (name) {
        Serial.print(F("Hello "));
        Serial.print(name);
        Serial.println(F("!"));
    } else {
        Serial.println(F("Hello. You did not specify your name."));
    }

    // Print age
    if (age) {
        Serial.print(F("You are "));
        Serial.print(age, DEC);
        Serial.println(F(" years old."));
    } else {
        Serial.println(F("You did not specify your age."));
    }
}

void cmdPrintIntArgument()
{
    int val;
    char *arg;

    // Get argument
    arg = term.getNext();
    if (arg == NULL) {
        Serial.println(F("Decimal or hex value not specified."));
        return;
    }

    // Try to convert decimal or hex argument character string to an int
    if (strncmp(arg, "0x", 2) == 0) {
        if (sscanf(arg, "0x%x", &val) != 1) {
            Serial.println(F("Cannot convert hex value."));
            return;
        }
    } else {
        if (sscanf(arg, "%d", &val) != 1) {
            Serial.println(F("Cannot convert decimal value."));
            return;
        }
    }

    // Print argument as string and value in hex / decimal
    Serial.print(F("String: "));
    Serial.print(arg);
    Serial.print(F("; "));

    Serial.print(F("Hex: 0x"));
    if (val < 0x10) {
        Serial.print(F("0"));
    }
    Serial.print(val, HEX);
    Serial.print(F("; "));

    Serial.print(F("Dec: "));
    Serial.println(val, DEC);
}

void cmdPrintStringArguments()
{
    int argIndex;
    char *arg;
    char *remaining;

    // Print arguments
    Serial.println(F("Arguments [1..4]: "));
    for (argIndex = 0; argIndex < 4; argIndex++) {
        arg = term.getNext();
        if (arg != NULL) {
            Serial.print(F("  "));
            Serial.print(argIndex);
            Serial.print(F(": "));
            Serial.println(arg);
        } else {
            break;
        }
    }

    if (argIndex == 0) {
        // No arguments specified
        Serial.println(F("  None"));
    } else {
        // Print remaining string
        remaining = term.getRemaining();

        if (remaining) {
            Serial.print(F("Remaining: "));
            Serial.println(remaining);
        }
    }
}
