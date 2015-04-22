    //create the options of the proxy
     public MatlabProxyFactoryOptions options = new MatlabProxyFactoryOptions.Builder()
    .setUsePreviouslyControlledSession(true)
    .setPort(6000)
     .build();
      //create the factory of proxies
    public MatlabProxyFactory factory = new MatlabProxyFactory(options);
  
  
   public  void oscEvent(OscMessage theOscMessage) throws MatlabConnectionException, MatlabInvocationException  {

   MatlabProxy proxy = factory.getProxy();
  // println(proxy.isExistingSession());
    
    
  /* print the address pattern and the typetag of the received OscMessage */
     //print("### received an osc message.");
      if (theOscMessage.checkAddrPattern("/muse/elements/alpha_absolute") == true)
      {
         //s1 = 0;
        for (int i=0 ; i<4; i++)   
         {
           f1[i] = (theOscMessage.get(i).floatValue());
      
           
         }

        
      }
      
      /////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/alpha_relative") == true)
      {
         //s1 = 0;
        for (int i=0 ; i<4; i++)   
         {
           f2[i] = theOscMessage.get(i).floatValue();
         }

        
      }
      //////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/beta_absolute") == true)
      {
         //s1 = 0;
        for (int i=0 ; i<4; i++)   
         {
           f3[i] = theOscMessage.get(i).floatValue();
         }

        
      }
      //////////////////////////////////////////////////////////////////////

      if (theOscMessage.checkAddrPattern("/muse/elements/beta_relative") == true)
      {
         for (int i=0 ; i<4; i++)   
         {
           f4[i] = theOscMessage.get(i).floatValue();
         }
      }
      
      //////////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/blink") == true)
      {
          s1 =theOscMessage.get(0).intValue();
      }
      
      //////////////////////////////////////////////////////////////////////////
      

      
      if (theOscMessage.checkAddrPattern("/muse/elements/delta_absolute") == true)
      {
          for (int i=0 ; i<4; i++)   
         {
           f5[i] = theOscMessage.get(i).floatValue();
         }  
       
      }
      ////////////////////////////////////////////////////////////////////////////
      
       
        if (theOscMessage.checkAddrPattern("/muse/elements/delta_relative") == true)
      {
          for (int i=0 ; i<4; i++)   
         {
           f6[i] = theOscMessage.get(i).floatValue();
         }  
       
      }
      //////////////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/experimental/concentration") == true)
       {
            s2 = theOscMessage.get(0).floatValue();
       }
       ////////////////////////////////////////////////////////////////////////////////
       
        if (theOscMessage.checkAddrPattern("/muse/elements/experimental/mellow") == true)
       {
            s3 = theOscMessage.get(0).floatValue();
       }
       /////////////////////////////////////////////////////////////////////////////////////
      
      if (theOscMessage.checkAddrPattern("/muse/elements/gamma_absolute") == true)
      {
             for (int i=0 ; i<4; i++)   
         {
           f7[i] = theOscMessage.get(i).floatValue();
         }
         
     }
     
        /////////////////////////////////////////////////////////////////////////////////////
          if (theOscMessage.checkAddrPattern("/muse/elements/gamma_relative") == true)
      {
             for (int i=0 ; i<4; i++)   
         {
           f8[i] = theOscMessage.get(i).floatValue();
         }
        
     }
     
        /////////////////////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/theta_absolute") == true)
      {
           for (int i=0 ; i<4; i++)   
         {
           f9[i] = theOscMessage.get(i).floatValue();
         }
       
      }
     
      if (theOscMessage.checkAddrPattern("/muse/elements/theta_relative") == true)
      {
           for (int i=0 ; i<4; i++)   
         {
           f10[i] = theOscMessage.get(i).floatValue();
           
         }
        
     
      }
     
     ////construct the input array
      for (int i =0; i<4;i++)
      {
        input[i][0] = f1[i]; // alpha absolute
        input[i+4][0] = f2[i];// alpha relative
        input[i+8][0] = f3[i]; // beta absolute
        input[i+12][0] = f4[i];// beta relative
        input[16][0] = s1; //blink
        input[i+17][0] = f5[i];// delta_absolute
        input[i + 21][0]= f6[i];// delta_relative
        input[25][0]= s2;//concentration
        input[26][0]=s3; //mellow
        input[i+27][0] = f7[i]; //gamma_ab
        input[i+31][0] = f8[i]; //gamma real
        input[i+35][0] = f9[i];//theta/ab
        input[i+39][0] = f10[i]; //theta_relative
        
      }
      
      
  
      
      /*for (int i =0;i<43;i++)
      {
     println(input[i][0]);
      }*/
    

     //Send the array to MATLAB, transpose it, then retrieve it and convert it to a 2D double array
      MatlabTypeConverter processor = new MatlabTypeConverter(proxy);
       processor.setNumericArray("array", new MatlabNumericArray(input, null));
       proxy.eval("array = array';");
       proxy.eval("array = a(array);");
    
       javaArray = processor.getNumericArray("array").getRealArray2D();
     //   System.out.println("Alert: " + javaArray[0][0]*100 + "  Drowsy "+ javaArray[1][0]*100 + "%");
        
         alert = javaArray[0][0];
         drowsy = javaArray[1][0];
      
        if (alert<0.5)
        {
          isDrowsy=true;
        }
        else
        isDrowsy = false;
       save_table();
      //Disconnect the proxy from MATLAB
        proxy.disconnect();
      
       // println(isDrowsy);
     
    }
