import { useState, useEffect } from 'react';
import { Search, RefreshCw, Heart, Star, Gift } from 'lucide-react';

export default function AdoptMeScript() {
  // Main states
  const [scriptLoaded, setScriptLoaded] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [loadingProgress, setLoadingProgress] = useState(0);
  const [showTradeUI, setShowTradeUI] = useState(false);
  
  // Target search and trade states
  const [targetUsername, setTargetUsername] = useState('');
  const [targetAvatar, setTargetAvatar] = useState(null);
  const [isSearching, setIsSearching] = useState(false);
  const [tradeSuccess, setTradeSuccess] = useState(false);
  
  // Execute script with loading progress
  const executeScript = () => {
    setIsLoading(true);
    setLoadingProgress(0);
    
    // Simulate loading progress
    const interval = setInterval(() => {
      setLoadingProgress(prev => {
        const newProgress = prev + Math.floor(Math.random() * 10) + 1;
        
        if (newProgress >= 100) {
          clearInterval(interval);
          setTimeout(() => {
            setIsLoading(false);
            setScriptLoaded(true);
            setShowTradeUI(true);
          }, 500);
          return 100;
        }
        
        return newProgress;
      });
    }, 150);
  };

  // Search for target and show avatar
  const searchTarget = () => {
    if (!targetUsername) return;
    
    setIsSearching(true);
    
    // Simulate API call to get target avatar
    setTimeout(() => {
      setIsSearching(false);
      // Use a placeholder image since we can't actually fetch real Roblox avatars
      setTargetAvatar(`/api/placeholder/200/200`);
    }, 800);
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-purple-100 p-4">

      {/* Loading screen */}
      {isLoading && (
        <div className="bg-white rounded-xl shadow-xl p-4 w-full max-w-sm">
          <div className="flex flex-col items-center space-y-4">
            <div className="text-2xl font-bold text-pink-500">
              Loading Adopt Me Script
            </div>
            <div className="text-sm text-gray-500">
              Please wait while we setting your Freezez Trade
            </div>
          </div>
          
          <div className="mt-4 h-3 bg-pink-100 rounded-full overflow-hidden">
            <div 
              className="h-full bg-pink-500 transition-all duration-300"
              style={{ width: `${loadingProgress}%` }}
            ></div>
          </div>
          
          <div className="text-center mt-2 text-pink-500 font-bold">
            {loadingProgress}%
          </div>
        </div>
      )}
      
      {/* Initial Execute Screen */}
      {!isLoading && !showTradeUI && (
        <div className="bg-white rounded-xl shadow-xl p-4 w-full max-w-sm">
          <div className="flex flex-col items-center space-y-2">
            <div className="text-2xl font-bold text-pink-500">
              Adopt Me Freeze Trade
            </div>
            <div className="text-sm text-gray-500 mb-4">
              Get the pets you want with one click!
            </div>
          </div>
          
          <button 
            onClick={executeScript}
            className="w-full py-3 bg-pink-500 text-white rounded-full font-bold hover:bg-pink-600 transition-colors shadow-md">
            START TRADING
          </button>
        </div>
      )}

      {/* Simple Trade UI */}
      {showTradeUI && (
        <div className="bg-white rounded-xl shadow-xl p-4 w-full max-w-sm">
          {/* Header */}
          <div className="border-b border-pink-100 pb-2">
            <div className="flex items-center justify-center space-x-2">
              <Gift className="h-5 w-5 text-pink-500" />
              <div className="text-lg font-bold text-pink-500">
                Adopt Me Freeze Trade
              </div>
            </div>
          </div>

          {/* Main content */}
          <div className="mt-4">
            <div className="flex flex-col space-y-3">
              <div className="text-sm font-medium text-pink-500">
                Find Player to Freeze Trade
              </div>
              <div className="text-xs text-gray-500">
                Enter username to start Freeze Trade
              </div>
              
              <div className="flex mt-2">
                <input
                  type="text"
                  value={targetUsername}
                  onChange={(e) => setTargetUsername(e.target.value)}
                  placeholder="Username"
                  className="flex-grow bg-white border border-pink-300 p-2 rounded-l-full text-pink-900 focus:outline-none focus:ring-2 focus:ring-pink-400 placeholder-pink-300"
                />
                <button
                  onClick={searchTarget}
                  className="bg-pink-500 text-white p-2 rounded-r-full hover:bg-pink-600">
                  {isSearching ? <RefreshCw className="h-5 w-5 animate-spin" /> : <Search className="h-5 w-5" />}
                </button>
              </div>
              
              {targetAvatar && (
                <div className="mt-2 flex items-center p-2 bg-pink-50 rounded-lg">
                  <div className="flex-shrink-0">
                    <div className="w-12 h-12 rounded-full overflow-hidden border-2 border-pink-300">
                      <img
                        src={targetAvatar}
                        alt="Target Avatar"
                        className="w-full h-full object-cover"
                      />
                    </div>
                  </div>
                  <div className="ml-3">
                    <div className="text-sm font-medium text-pink-900">
                      {targetUsername}
                    </div>
                  </div>
                </div>
              )}
              
              <button
                onClick={() => {
                  if (targetAvatar) {
                    // Set state for loading
                    setIsSearching(true);
                    
                    // After 3 seconds of loading, show success for 2 seconds
                    setTimeout(() => {
                      setIsSearching(false);
                      setTradeSuccess(true);
                      
                      // After 2 seconds of success message, go back to normal
                      setTimeout(() => {
                        setTradeSuccess(false);
                      }, 2000);
                    }, 3000);
                  }
                }}
                disabled={!targetAvatar || isSearching || tradeSuccess}
                className={`w-full py-2 px-4 rounded-full font-bold shadow-md transition-all ${
                  tradeSuccess 
                    ? 'bg-green-500 text-white' 
                    : targetAvatar && !isSearching
                      ? 'bg-pink-500 hover:bg-pink-600 text-white hover:shadow-lg' 
                      : 'bg-pink-200 text-pink-400 cursor-not-allowed'
                }`}
              >
                {isSearching ? (
                  <div className="flex items-center justify-center space-x-1">
                    <RefreshCw className="h-4 w-4 animate-spin" />
                    <span>LOADING...</span>
                  </div>
                ) : tradeSuccess ? (
                  <div className="flex items-center justify-center space-x-1">
                    <Star className="h-4 w-4" />
                    <span>SUCCESS!</span>
                  </div>
                ) : (
                  <div className="flex items-center justify-center space-x-1">
                    <Heart className="h-4 w-4" />
                    <span>FREEZE TRADE</span>
                  </div>
                )}
              </button>
            </div>
          </div>

          {/* Footer */}
          <div className="mt-4 pt-2 border-t border-pink-100">
            <div className="flex justify-center">
              <div className="text-xs text-gray-400">
                Adopt Me Freeze Trade • v2.0
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
                }
